Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89177D908C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjJ0IDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjJ0IC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 04:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F09196
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 01:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE86C433C8;
        Fri, 27 Oct 2023 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698393777;
        bh=Hu+heOF/RvukwKlaF4hhSTFt4xvsmU1ObUFoPfCTfo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8ropQ4sRy3uEd4+vJ56Ozt4nexqZU8nwhPC4akixvGn2i5EOfhIepokrXgUQWKw3
         teNSbhlhZpE3UzNKPEpsOKLnyHPYbzRjFnPrgjqSzQcpKizCS1hRcM4LaMivqg4liN
         PGDztjhFaaLfncMJBJ16zEoVq1MoFgARnfDl0DMDRwHySz5hZ54AD8p5DZ/uE3dojV
         QK0zzFLJ6QF1Wl/Aa2LbrHCEuVAdrRtNXmP+kEm1+GWCb9UucluEmmws3o/De0/610
         vTU0J7nCSL5d2EZjAOuJKwtLdcTySANW9U7d5YBx+2IhHHhRtezWzJ6yWit1qPv5Tp
         qNT9r1GOaBtJg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fs: fix build error with CONFIG_EXPORTFS=m or not defined
Date:   Fri, 27 Oct 2023 10:02:49 +0200
Message-Id: <20231027-fraktionslos-kartbahn-77e0714f02bc@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026204540.143217-1-amir73il@gmail.com>
References: <20231026204540.143217-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=brauner@kernel.org; h=from:subject:message-id; bh=Hu+heOF/RvukwKlaF4hhSTFt4xvsmU1ObUFoPfCTfo4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRa5y3mrD62zOeaw+/dpW4eH0srJ3yTMpplNCGpK2IqR/ge 2+eLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiasrwP7bNx/QCn91u7a9WWtUyxw PsUxsSCnvtF/x8WpQbI/DoOCPDbk3lUrvO34ueXI7oEHwR01RctFFjq8P32AId1+W/tat4AQ==
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

On Thu, 26 Oct 2023 23:45:40 +0300, Amir Goldstein wrote:
> Many of the filesystems that call the generic exportfs helpers do not
> select the EXPORTFS config.
> 
> Move generic_encode_ino32_fh() to libfs.c, same as generic_fh_to_*()
> to avoid having to fix all those config dependencies.
> 
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

[1/1] fs: fix build error with CONFIG_EXPORTFS=m or not defined
      https://git.kernel.org/vfs/vfs/c/45ac7f1910db
