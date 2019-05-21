Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B824DCA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEULTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 07:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfEULTF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 07:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31A013082E6B;
        Tue, 21 May 2019 11:19:00 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3773665F4;
        Tue, 21 May 2019 11:18:57 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Xuewei Zhang" <xueweiz@google.com>, jlayton@kernel.org,
        "Grigor Avagyan" <grigora@google.com>,
        "Trevor Bourget" <bourget@google.com>,
        "Nauman Rafique" <nauman@google.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] lockd: Show pid of lockd for remote locks
Date:   Tue, 21 May 2019 07:18:57 -0400
Message-ID: <C3DA91E7-B905-4A74-94A0-2BF4AFE1FD05@redhat.com>
In-Reply-To: <20190520205106.GA29025@fieldses.org>
References: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
 <3A924C3F-A161-4EE2-A74E-2EE1B6D2CA14@redhat.com>
 <CAPtwhKoF0XTuFa5msGB_eiiwRcJA0kK7eu6Rw6-b-5+8Qy0DDw@mail.gmail.com>
 <C5CB1B1E-59BD-4DB6-82D8-CE8E641CAC5A@redhat.com>
 <FF6B465E-DA4C-430D-ABEE-6053EF1E9A44@redhat.com>
 <20190520205106.GA29025@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 21 May 2019 11:19:05 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20 May 2019, at 16:51, J. Bruce Fields wrote:

> On Mon, May 20, 2019 at 10:22:00AM -0400, Benjamin Coddington wrote:
>> Ok, I just noticed that we set fl_owner to the nlm_host in
>> nlm4svc_retrieve_args, so things are not as dire as I thought.  What
>> would be nice is a sane set of tests for NLM..
>
> What would we have needed to catch this?  Sounds like it turns
> multi-client testing wouldn't have been required?  (Not that that 
> would
> be a bad idea.)

Two NLM clients would be ideal to exercise the full range of expected 
lock behavior.  I suspect that's something I can do with what's in pynfs 
today, but I haven't looked yet.  I suppose if there's a test for NLM I 
should make one for v4 too..

Ben
