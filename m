Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9791900F9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWWMo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 18:12:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:52982 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWWMn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Mar 2020 18:12:43 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jGVJB-0004pb-Rc; Tue, 24 Mar 2020 01:12:34 +0300
Subject: Re: [PATCH] nfsd: memory corruption in nfsd4_lock()
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
 <7a3124cd2431eabe2495e0e8cd80068fe7261b1b.camel@kernel.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <e115cde6-315e-73ae-c89a-93eb5521e6c1@virtuozzo.com>
Date:   Tue, 24 Mar 2020 01:12:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7a3124cd2431eabe2495e0e8cd80068fe7261b1b.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/23/20 3:18 PM, Jeff Layton wrote:
> On Mon, 2020-03-23 at 10:55 +0300, Vasily Averin wrote:
>> New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
>> does not initialised nbl_list and nbl_lru.
>> If conflock allocation fails rollback can call list_del_init()
>> access uninitialized fields and corrupt memory.
>>
>> Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for v4.1+ lock")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Good catch! Is there any reason not to just fix this by initializing the
> list_heads in find_or_allocate_block? That seems like it'd be a simpler
> fix.
> 

Rollback in nfsd4_lock() is not optimal, I've tried to improve it too,
However I agree such improvement is not a simplest fix
and it anyway does not make whole rollback perfect.

I think it's better to re-send small fix for the found problem,
and prepare separate patches for rollback improvements,

Thank you,
	Vasily Averin
