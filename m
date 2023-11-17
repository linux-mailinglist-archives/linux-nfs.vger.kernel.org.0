Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B97EEB6C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 04:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjKQD2u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 22:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQD2t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 22:28:49 -0500
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA2B0;
        Thu, 16 Nov 2023 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700191722;
        bh=t1QptpHB+j2hjtkZxMW66dbJO4vcH9gktTNMOo4SZM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=endsVjoD/yjsuV0gPrvweXz68xdycKohLRDSx8f+mEL2URPffLmCRjs+fS5slelfg
         jWcWNeE10wZYVgBm1c7dIufnDvUEdGt7WRH+8lHxKIawSew/Qmu09glu9B3esF8CJ5
         zf9E4zBoXh7pzLK0vBHLFSyQJ6bEBUS+Z5FgJQ9g=
Received: from [192.168.31.137] ([116.128.244.171])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 7243DE1E; Fri, 17 Nov 2023 11:28:36 +0800
X-QQ-mid: xmsmtpt1700191716tu68o2yw3
Message-ID: <tencent_7081EC6CCB41F8B0966FCEB01B7AED66C409@qq.com>
X-QQ-XMAILINFO: MX+1SEN3H+wAZ8oLfd06aJMpam71+X3o79wb4d4a3ttV8WyaYYa10p5AmZRBVD
         zJuOWN3vKJFxXxc/yyZPPLXsY0CKTd117/GCz6d05d5xrKsi7VEXfjCU1tKrQk4G11uoyqiIwFpf
         hwI5BxxXgdpNlT9dwCDLj65GmdsiwWQCEqKonaMfxZBVX34JBEYEiR1TiQCA3xuaESwj+iI48kaF
         sIfe+0eACZ65KaBr4/AQ5MkERyo8Z6mjaq3jBYHMjszTrSwxlDhks3c02CEuhRqxTP0osKFFEVlv
         YoOQ87g6hU9om2cq352Emev8o9nJCFreKRvqrHsxuW51wtIByQ0bzkisDHs03BC0MSIpMgWq0Nxc
         s7rKv+OJJYeN3OeyU2kd+v32A9WXfS0SKDVOofuWW2z8xsH2rRs8VyAtGTui0wKl3IK1xkiKGZOx
         PQCqhqvPYtRf5pl4bCB2cWLYyBSz2wHaKmhmahnQdl2sNzlOOvisqEeMt/zsND2thXgicrEw/Izn
         Ui6Fv8lBrSKKVroUB2rCKiLg4trmXFySMb9c3Lkj7wmFWRWQy971UUELcRh9pX1kVh8D/uQ2zMzS
         9P2fUhHt1PZ+twZdKxO2Vk7uI2/+dfxyDXHDnvW+f1JH4baptALWagHxP+WpyCPqRcgrzYJ4SbCF
         uYSd8K/+gFnVtq/Bs2dnd6nNwuXSBNe4/PraG/eaRTUCvU4LoEzSflD/5skCTsGvHzfYwGJ3fhdX
         CrkKd1AKuMEkDhQRtjjy0PTr9DfCmKEt33E9s/7241Dcx1UPnlZbFoT6Jxt58Ev9V+IYlE+tzlcA
         GY0fmfYCYwGOSWiAWvPyD0AvwoAji0S3mE1SCalWi456hFjMhLUfGykkLyCcDpXq1Q6vT9Ls79nL
         vOF9WgNTWJRLqn7jCbBju2oUwJzDlPo3hZ5SzbAVkIJ1MhanfNS8zVDF5iTenZJM11dXqQrxRK
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <835b2d65-0124-436f-9d31-21f0fb3bb48d@foxmail.com>
Date:   Fri, 17 Nov 2023 11:28:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "huangjinhui@kylinos.cn" <huangjinhui@kylinos.cn>,
        "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
        "liuyun01@kylinos.cn" <liuyun01@kylinos.cn>,
        "huhai@kylinos.cn" <huhai@kylinos.cn>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
 <2023103055-anaerobic-childhood-c1f1@gregkh>
 <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
 <2023103055-saddled-payer-bd26@gregkh>
 <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
 <3b8caab5918d06f436a889bc1dba09686fc0fad5.camel@hammerspace.com>
Content-Language: en-US
From:   ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <3b8caab5918d06f436a889bc1dba09686fc0fad5.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/10/30 22:56, Trond Myklebust wrote:
> A refactoring is by definition a change that does not affect code
> behaviour. It is obvious that this was never intended to be such a
> patch.
>
> The reason that the bug is occurring in 4.19.x, and not in the latest
> kernels, is because the former is missing another bugfix (one which
> actually is missing a "Fixes:" tag).
>
> Can you therefore please check if applying commit 22876f540bdf ("NFS:
> Don't call generic_error_remove_page() while holding locks") fixes the
> issue.
>
> Note that the latter patch is needed in any case in order to fix a read
> deadlock (as indicated on the label).
>
> Thanks,
>    Trond
>
After applying commit 22876f540bdf ("NFS: Don't call 
generic_error_remove_page() while holding locks"), I encountered an 
issue of infinite loop:

write ... nfs_updatepage nfs_writepage_setup nfs_setup_write_request 
nfs_try_to_update_request nfs_wb_page if (clear_page_dirty_for_io(page)) 
// true nfs_writepage_locked // return 0 nfs_do_writepage // return 0 
nfs_page_async_flush // return 0 nfs_error_is_fatal_on_server 
nfs_write_error_remove_page SetPageError // instead of 
generic_error_remove_page // loop begin if 
(clear_page_dirty_for_io(page)) // false if (!PagePrivate(page)) // 
false ret = nfs_commit_inode = 0 // loop again, never quit

before applying commit 22876f540bdf ("NFS: Don't call 
generic_error_remove_page() while holding locks"), 
generic_error_remove_page() will clear PG_private, and infinite loop 
will never happen:

generic_error_remove_page truncate_inode_page truncate_cleanup_page 
do_invalidatepage nfs_invalidate_page nfs_wb_page_cancel 
nfs_inode_remove_request ClearPagePrivate(head->wb_page)

If applying this patch, are other patches required? And I cannot 
reproducethe read deadlock bug that the patch want to fix, are there 
specific conditions required to reproduce this read deadlock bug?

