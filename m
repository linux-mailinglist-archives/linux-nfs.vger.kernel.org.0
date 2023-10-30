Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8057DB547
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 09:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJ3IjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3IjW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 04:39:22 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34107A7
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698655155;
        bh=W8G5j9YhA2I2eRk3M6nv4DdkaLiBeUrHLN00MhMD31Q=;
        h=Date:To:Cc:From:Subject;
        b=QG9UnVkFwwH1XC3Ovx446jHVERTLDF+B/GHWGtldwBLjcvjNaz0RzObeOdVTR8HPG
         VitaOLti6YQs+oD/kDXI6pifsMe5dRnhxtt1fWCv+a29QDTJ9HYko63OJPgxI4ccPk
         GHVBMxcMdwi8eZzSwWOkF/ZPRr9xMPV9f/9yQDr8=
Received: from [192.168.31.137] ([116.128.244.171])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 9CB92A0B; Mon, 30 Oct 2023 16:39:11 +0800
X-QQ-mid: xmsmtpt1698655151t2dqeblop
Message-ID: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UE1TRfKdo6eHcsxFwLL98nLeAI/pEurbf74ZhutHLWVTVWaTsqjU
         jrFgNtY2wtOX6BDGB7GXAPHbCK7hGBZSRFwMDSstJR+1Jf6i15Fad08SmCfmu5D4UEx24fWqmzkO
         DWcSC5bXjk/ORj8IMylxT80bgV6fFhyHpkt7m/akpW96AE107jWpuQ/+X1Pl9bGiFsQ23ujC4uak
         5NbHgy7MINE5WOSrcA/IxKQ/SNTMMUbVuO8hU0iBERf3VUuLreNR3IPIuwdhc5fuuxwdFRx0NASJ
         SzBXAjL6RIIeeqxOet5YWm0B2a4nra0nkoTkbLwgtYy3TxLmCZxcMr9jvfS1M/OpX5iVsVxm/BKo
         NdAiyovIMxBwAKdcVk2Fwj7YDTwB3PFuzgKx24ivg+xw2AWIVh+jEbT4z4Zcshjp1DmyPw+J0/Fz
         ZGN39TTXr3dRTCV5zMfrzfq1aaw/fcGxec99GjKRbeXV/OpfXqE6g0CYLsBjDSGvDTc0LUXlggdk
         sJdGvzYHbxvc5cNX26yX7iDEZ377oHxd1yn1+TKtG82zCBhGVzKXTw7igmviDaoSqoe6rajjI8U0
         VWmdSGHT7+b8uF5J9LDZgBJ3pKc9UwpD7pP1IxuE/TaZ9rbDQGOUOq7MwuxnWzX4gn6M9R8Frf9M
         2PihA480TEPPhW+b5rF38DooUOae9bmLEeoYAIg9T1CTngF1K3HjvE6mvuqSElg73SD4W8V8cbha
         rhJO/OrygQRkNvsal5tqQ1gYDL60m7b6fr4Fjl2sewNzpWM5ZAdNbOzzOMtwRaBSR5qXEdZEm7ev
         hJDygZKr7TgMocEJ9WKnVwWDiuNsMSUhoH7lzXuVBpm73WcbqBtS2etcGI3j/vrb7r9FHxHIBpft
         EinB9bSkIxu84yHkomCL11Ile2jqR/kikZIXq5UmD5krckqDlUlhDSQxt4JRe+AV+66RkiEZdHIm
         B3a9LpeoMe/ImUq5Cf8bYFIp6x7WIk2ovL7kfcO8UHh9yXZHF4yB8s76t7j/kNWIDgQ4elk8luDR
         2ubmq6tnQqCSa28DCD/czzIKLGAGU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <9b161a5b-201a-4f82-b9ef-5f9d7eba4529@foxmail.com>
Date:   Mon, 30 Oct 2023 16:39:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     gregkh@linuxfoundation.org, trond.myklebust@hammerspace.com,
        chenxiaosong@kylinos.cn
Cc:     Anna.Schumaker@Netapp.com, sashal@kernel.org,
        liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
From:   ChenXiaoSong <chenxiaosongemail@foxmail.com>
Subject: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt file
 writeout due to fatal errors"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond and Greg:

LTS 4.19 reported null-ptr-deref BUG as follows:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
Call Trace:
  nfs_inode_add_request+0x1cc/0x5b8
  nfs_setup_write_request+0x1fa/0x1fc
  nfs_writepage_setup+0x2d/0x7d
  nfs_updatepage+0x8b8/0x936
  nfs_write_end+0x61d/0xd45
  generic_perform_write+0x19a/0x3f0
  nfs_file_write+0x2cc/0x6e5
  new_sync_write+0x442/0x560
  __vfs_write+0xda/0xef
  vfs_write+0x176/0x48b
  ksys_write+0x10a/0x1e9
  __se_sys_write+0x24/0x29
  __x64_sys_write+0x79/0x93
  do_syscall_64+0x16d/0x4bb
  entry_SYSCALL_64_after_hwframe+0x5c/0xc1

The reason is: generic_error_remove_page set page->mapping to NULL when 
nfs server have a fatal error:

nfs_updatepage
   nfs_writepage_setup
     nfs_setup_write_request
       nfs_try_to_update_request // return NULL
         nfs_wb_page // return 0
           nfs_writepage_locked // return 0
             nfs_do_writepage // return 0
               nfs_page_async_flush // return 0
                 nfs_error_is_fatal_on_server
                 generic_error_remove_page
                   truncate_inode_page
                     delete_from_page_cache
                       __delete_from_page_cache
                         page_cache_tree_delete
                           page->mapping = NULL // this is point
       nfs_create_request
         req->wb_page    = page // the page is freed
       nfs_inode_add_request
         mapping = page_file_mapping(req->wb_page)
           return page->mapping
         spin_lock(&mapping->private_lock) // mapping is NULL

It is reasonable by reverting the patch "89047634f5ce NFS: Don't 
interrupt file writeout due to fatal errors" to fix this bug?


This patch is one patch of patchset [Fix up soft mounts for 
NFSv4.x](https://lore.kernel.org/all/20190407175912.23528-1-trond.myklebust@hammerspace.com/), 
the patchset replace custom error reporting mechanism. it seams that we 
should merge all the patchset to LTS 4.19, or all patchs should not be 
merged. And the "Fixes:" label is not correct, this patch is a 
refactoring patch, not for fixing bugs.

