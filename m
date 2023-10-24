Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E367D5762
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjJXQHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJXQHd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 12:07:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CD10D1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Oct 2023 09:07:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715D3C433C8;
        Tue, 24 Oct 2023 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698163651;
        bh=dcoeFmm3TJwc+pmBDewraxuN1s4KeQO67oBJ4IAfQC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxtiBbLFq1SAojCocIzKrGh6CqGJMqcrkuwPjrN+acDiQWaJyj4QPQxo7lu5d7xEG
         xiP79s70tPenQMSvvHUahFxzYd8Dw6cyyZu0bH8mBpYVurDJV42sAjyaf8C5QUp3Ih
         0+NWiI3I5+A4tgdMr4U18l+AqesST40IUiJGY3zIoR5F+7DG9DaJPROPmgXZsrWz1s
         KIO/9JctIbdAa/B4TjRvmGPfU3yIUpCRcGKEyuQq+JjKBE+dcR9AP1JxIM8vxa74/P
         KiXb+gsaPen2sALHOtYeZNRw8YOjjpe/0VsMDm0ZHMHdBLMUlWv4eAEd1nVd550TPf
         DKAHPql72NKDw==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] fs: report f_fsid from s_dev for "simple" filesystems
Date:   Tue, 24 Oct 2023 18:07:11 +0200
Message-Id: <20231024-palastartig-diese-ac7966e35075@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023143049.2944970-1-amir73il@gmail.com>
References: <20231023143049.2944970-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org; h=from:subject:message-id; bh=dcoeFmm3TJwc+pmBDewraxuN1s4KeQO67oBJ4IAfQC8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSav17Gc6qzyVPu2N2Q96JvJHc3mH2Y+5dJoOMZ87TVClrq f28v7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIx3FGhmsM++U3KqkuiP36Nue8Gs ePo980CzNN7KZWsCZnPpz8/jjDf3+/mwJ+nr+Tnvdcbjnfw/nNftrN60wabII3t5tPvTwxjg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 23 Oct 2023 17:30:49 +0300, Amir Goldstein wrote:
> There are many "simple" filesystems (*) that report null f_fsid in
> statfs(2).  Those "simple" filesystems report sb->s_dev as the st_dev
> field of the stat syscalls for all inodes of the filesystem (**).
> 
> In order to enable fanotify reporting of events with fsid on those
> "simple" filesystems, report the sb->s_dev number in f_fsid field of
> statfs(2).
> 
> [...]

Applied to the vfs.f_fsid branch of the vfs/vfs.git tree.
Patches in the vfs.f_fsid branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.f_fsid

[1/1] fs: report f_fsid from s_dev for "simple" filesystems
      https://git.kernel.org/vfs/vfs/c/14673976a658
