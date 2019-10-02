Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69FBC6219
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfJBKlo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 06:41:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfJBKlo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 2 Oct 2019 06:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 162ED10C094C;
        Wed,  2 Oct 2019 10:41:44 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80F5A1001B08;
        Wed,  2 Oct 2019 10:41:43 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     Anna.Schumaker@netapp.com, linux-nfs@vger.kernel.org,
        jamespharvey20@gmail.com
Subject: Re: [PATCH] SUNRPC: fix race to sk_err after xs_error_report
Date:   Wed, 02 Oct 2019 06:41:44 -0400
Message-ID: <605DFB04-3686-4CCE-A87E-905E91E01F50@redhat.com>
In-Reply-To: <d9bf3f1092ed0361cc344e04a915ea337a3aa9e8.camel@hammerspace.com>
References: <9796ba15d926f65923965c2aedf777aaa59861e8.1569954618.git.bcodding@redhat.com>
 <d9bf3f1092ed0361cc344e04a915ea337a3aa9e8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 02 Oct 2019 10:41:44 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Oct 2019, at 15:38, Trond Myklebust wrote:

> On Tue, 2019-10-01 at 14:30 -0400, Benjamin Coddington wrote:
>> ...
>> diff --git a/include/linux/sunrpc/xprtsock.h
>> b/include/linux/sunrpc/xprtsock.h
>> index 7638dbe7bc50..8ffae73dea6c 100644
>> --- a/include/linux/sunrpc/xprtsock.h
>> +++ b/include/linux/sunrpc/xprtsock.h
>> @@ -56,6 +56,7 @@ struct sock_xprt {
>>  	 */
>>  	unsigned long		sock_state;
>>  	struct delayed_work	connect_worker;
>> +	int			xprt_err;
>
> Perhaps move this down just after srcport so we don't create an
> unnecessary hole in the structure?

Ok!

>>  	struct work_struct	error_worker;
>>  	struct work_struct	recv_worker;
>>  	struct mutex		recv_mutex;
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index e2176c167a57..7fe77eef7080 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -1250,12 +1250,12 @@ static void xs_error_report(struct sock *sk)
>>  		goto out;
>>
>>  	transport = container_of(xprt, struct sock_xprt, xprt);
>> -	err = -sk->sk_err;
>> -	if (err == 0)
>> +	transport->xprt_err = -sk->sk_err;
>
> Doesn't this need a smp write barrier to ensure it isn't reordered with
> the set_bit() in xs_run_error_worker()?

Yes, it does need that or the error_worker may clear the bit without seeing
the error.

Ben
