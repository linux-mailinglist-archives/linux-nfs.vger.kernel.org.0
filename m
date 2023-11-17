Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05867EEB8F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbjKQEJx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 23:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbjKQEJw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 23:09:52 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7E98;
        Thu, 16 Nov 2023 20:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700194181;
        bh=At520qKDeX3E1KIIClRLx//A2/xcILPB3gnDlw8ZE08=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XnS3s2tB46u8ds19DN1mFA7F9oJDpJT8FkQaexibm0OWrikkRylgktBHiTtnjUYmO
         zrpEfD2+5uuncvtxW7SoQh1bBlYxHUlh87HvqiDok4CR2J3YbWQ8Nh2jOaNXfUhLFN
         dOfUODhb5J/gtkLWQCmDmqeFvvsSpcJkyWwEy8/Y=
Received: from [192.168.31.137] ([116.128.244.171])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 265B9673; Fri, 17 Nov 2023 12:09:37 +0800
X-QQ-mid: xmsmtpt1700194177t86eil4p2
Message-ID: <tencent_F89651CE8E1BFCEC42C4BFEDD0CA77F82609@qq.com>
X-QQ-XMAILINFO: ObFHHlrAm440315lOe38z+J5oFMziPtveeFGLU4JO6UI+h6J+5+9Z5cJ7VyZvS
         B9Un2LhVR5Mrg0CngHtiRKUVkncFNCQtMqZ7DGfLFZ7hJNfMugz9j7vLBZDLDI2t/MQjzoo8yQXX
         1TGkcO0cfiKJGxor6bGsknrXcIAGWlFKxwMpsklZGuE2VkDhGBaaNUISCPh3aDIDiDel21u8lrln
         swagzSLrNc5wb/ttRAbPjEmN7qBwXa0GVbxnufbzOirTTWT0tTHLYHfXqc0twvHf0djQ1jm70ZVf
         Ehhrkjj4whBDYigT6WyHhPxQ9LDZOHtHrewsqDl4gW3aEIVZ0i8DyaU3MVkjjbe+UITyfTjkucxN
         HhVns2OF2EhlxT3xeqO7QOCCqThE0AbBIHmAR9pk2uE/wZjy+uvjgYAeFtKqK+VKqTIqSroTyxUZ
         +uDkrGDr7iy10NYFAzLtbanIDtfAbridyk/xfULMq4wtF3qFcWv/6Qf0qsPluaBgEuXuL4jpd3oJ
         a+yOryWdWb4IxwtpQVqwx8y/nl/XRcxraHju1Vv8fit0HCOvtuDELTyJcBE5S+hYNXbbkRYU0EFV
         pouQVo5FGy6mNP47vRGtJPmlH/PmV6rNjFd5NZKOibWwZ/g+vOmFhJd+dmwyvHYuW4WmR06NjUrX
         EB50gJALYlxZ8gEnXxyLbYkUyw3Y/cUVUFno/lq6e/+QvsEqvVKadXxifTaAACUxTBROuAjF+k0U
         194aapbdGHSfgnWyssSgsEpAOEBmMLpP1BIrFL9TriBJT3m/1WJFE/8IReTfa4zwkyIIqKWc2vph
         wmBGA/YkIlIBTERSwmvE1WqlPZOrWA5B1TY7d0mvvDLQOrJkHVfG+Jd1gL6kZSjM+FGdtNSJyw9j
         2rAf2QaTHVQjalLzjH7OyTFaRN/AqiZtvefe0+TDFDhI0EQt0rLRXO9zWfuF2Hfh+Fo8OJvvBdzZ
         maNcVKbPNNkS0nstAjVljRzlO6rKZ7
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <22e31dd3-6557-4019-b46f-32ac56cffa48@foxmail.com>
Date:   Fri, 17 Nov 2023 12:09:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Content-Language: en-US
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
From:   ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <3b8caab5918d06f436a889bc1dba09686fc0fad5.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

Sorry, the previous email had formatting issues. I'll resend it.


After applying commit 22876f540bdf ("NFS: Don't call 
generic_error_remove_page() while holding locks"), I encountered an 
issue of infinite loop:

write
   ...
   nfs_updatepage
     nfs_writepage_setup
       nfs_setup_write_request
         nfs_try_to_update_request
           nfs_wb_page
             if (clear_page_dirty_for_io(page)) // true
             nfs_writepage_locked // return 0
               nfs_do_writepage // return 0
                 nfs_page_async_flush // return 0
                   nfs_error_is_fatal_on_server
                   nfs_write_error_remove_page
                     SetPageError // instead of generic_error_remove_page
             // loop begin
             if (clear_page_dirty_for_io(page)) // false
             if (!PagePrivate(page)) // false
             ret = nfs_commit_inode = 0
             // loop again, never quit


before applying commit 22876f540bdf ("NFS: Don't call 
generic_error_remove_page() while holding locks"), 
generic_error_remove_page() will clear PG_private, and infinite loop 
will never happen:

generic_error_remove_page
   truncate_inode_page
     truncate_cleanup_page
       do_invalidatepage
         nfs_invalidate_page
           nfs_wb_page_cancel
             nfs_inode_remove_request
               ClearPagePrivate(head->wb_page)


If applying this patch, are other patches required? And I cannot 
reproducethe read deadlock bug that the patch want to fix, are there 
specific conditions required to reproduce this read deadlock bug?


