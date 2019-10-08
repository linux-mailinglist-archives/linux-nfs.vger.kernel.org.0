Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62169CF0B5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2019 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfJHCAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Oct 2019 22:00:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbfJHCAK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 7 Oct 2019 22:00:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E37F853114F9BFF904DF;
        Tue,  8 Oct 2019 10:00:08 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.145) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 10:00:08 +0800
Subject: Re: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
References: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
 <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
 <5c50a4be3562877a5d96523e943b9976a3792e23.camel@hammerspace.com>
 <cb955e718bd3c62f9c23661e95db77efa65d7177.camel@hammerspace.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <4096d9e4-f6a2-b1e1-4f52-81cf44fc4a1f@huawei.com>
Date:   Tue, 8 Oct 2019 10:00:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cb955e718bd3c62f9c23661e95db77efa65d7177.camel@hammerspace.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.145]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for your review.

I think PG_REMOVE and PG_INODE_REF can't be both setted except in
'nfs_inode_remove_request' function.

nfs_inode_remove_request
	// maybe set PG_REMOVE here.
	nfs_page_group_sync_on_bit(req, PG_REMOVE)
		nfs_page_group_lock(req);
		nfs_page_group_sync_on_bit_locked
			WARN_ON_ONCE(test_and_set_bit(bit, &req->wb_flags));
		nfs_page_group_unlock(req);
	// But also clear the PG_INODE_REF flag.
	test_and_clear_bit(PG_INODE_REF, &req->wb_flags)

'nfs_lock_and_join_requests' also need the PG_HEADLOCK flag:

nfs_lock_and_join_requests
	nfs_page_group_lock(head);
		test_and_clear_bit(PG_REMOVE, &head->wb_flags)
	nfs_page_group_unlock(head);


在 2019/10/5 22:35, Trond Myklebust 写道:
> However nfs_lock_and_join_requests() looks like it does need to change
> to something like the following:
> 
>          /* Postpone destruction of this request */
> -       if (test_and_clear_bit(PG_REMOVE, &head->wb_flags)) {
> -               set_bit(PG_INODE_REF, &head->wb_flags);
> +       if (test_and_clear_bit(PG_REMOVE, &head->wb_flags) &&
> +           !test_and_set_bit(PG_INODE_REF, &head->wb_flags)) {
>                  kref_get(&head->wb_kref);
>                  atomic_long_inc(&NFS_I(inode)->nrequests);
>          }
> 
> 
> Do you agree?

