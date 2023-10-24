Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22627D5766
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Oct 2023 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjJXQIW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Oct 2023 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJXQIW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Oct 2023 12:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDB83
        for <linux-nfs@vger.kernel.org>; Tue, 24 Oct 2023 09:08:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600DDC433C7;
        Tue, 24 Oct 2023 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698163699;
        bh=DmTXuUzm5yWar7gyoWLtzIUd1urJOVtYQp3q4zQCSoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D22AxvDSYehp1KvkIyyFRiCqJNz7qrUq7z69fwjpKeQhlQusRHVhEMYxkEfxi4wRW
         vbie+4vmPibYgjq2DeVaNC2wr3KGjMg1YA/1xIPzAfC9Z8Bhjvune/dWekIMrROtXR
         xwEZC/ma54fwcHjKdrrc2b6axIdZaLFvE8AucCXfjVvpz5nQ5LTIQqCqq5uulYhnAU
         JonZDOfFbCjFyJ1IAKC+FnbtSdILv2zrypC8OHfp1l3VbqKqXfw/S5W6LtDBWTDkRT
         wfSKKWd6XNCrxQbj42hHFHq465MI945OAssC8xCGJlaXkFTqDqM1GA+rTXIjAGsG25
         uGHt1r+1qpEkQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Support more filesystems with FAN_REPORT_FID
Date:   Tue, 24 Oct 2023 18:08:11 +0200
Message-Id: <20231024-filmwelt-wegbegleiter-08412bcf1388@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
References: <20231023180801.2953446-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=brauner@kernel.org; h=from:subject:message-id; bh=zl9/HcJXzP0yG7d5KWmasNM+q31vAecbKVWYY1+DH8k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSav74Rp7f/0iquBKEHM1UvBX76tednjal26LIuSZMID81P Gh2pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRlmb4Z+nUJJGw4ejlh3+mX/qbdu zn7Tsx1tvDkn/efjQvNGbXDy1Ghhs3Hn2TPt6RVKVe6JF8Yu5UJcOsp3dlf9d7Vzt+PhvXwwUA
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

On Mon, 23 Oct 2023 21:07:57 +0300, Amir Goldstein wrote:
> Christian,
> 
> The grand plan is to be able to use fanotify with FAN_REPORT_FID as a
> drop-in replacement for inotify, but with current upstream, inotify is
> supported on all the filesystems and FAN_REPORT_FID only on a few.
> 
> Making all filesystem support FAN_REPORT_FID requires that all
> filesystems will:
> 1. Support for AT_HANDLE_FID file handles
> 2. Report non-zero f_fsid
> 
> [...]

"Late is the hour in which this patchset chooses to appear."
Let's give it some -next exposure.

---

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

[1/4] exportfs: add helpers to check if filesystem can encode/decode file handles
      https://git.kernel.org/vfs/vfs/c/66c62769bcf6
[2/4] exportfs: make ->encode_fh() a mandatory method for NFS export
      https://git.kernel.org/vfs/vfs/c/dfaf653dc415
[3/4] exportfs: define FILEID_INO64_GEN* file handle types
      https://git.kernel.org/vfs/vfs/c/2560fa66d2ac
[4/4] exportfs: support encoding non-decodeable file handles by default
      https://git.kernel.org/vfs/vfs/c/950f27681add
