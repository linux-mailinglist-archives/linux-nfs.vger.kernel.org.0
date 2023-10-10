Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F17BFBC2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJJMtj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjJJMtj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 08:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15BA9
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 05:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCBAC433C8;
        Tue, 10 Oct 2023 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942176;
        bh=hFf0sMrVnaxFTA/5i6Q8Ksw8dlB2uxPJyYLJtillliU=;
        h=Subject:From:To:Cc:Date:From;
        b=gyoTMQpM9T8HPhsOCEqar4W150zGQzruEzetNIZPPDKVVuYpupbjewv0eJQou/cqg
         3ZHwfwWcv6NJ0tiBHd5jced+U5kAfCQ6QkUtGrXA9GpSxoSGRR6AAh33pPoSCPMvdz
         wAzxEU7C6FO0NVmaz9QMV9053oPsb8y/DVTJBVutbGoqQe5YayA9t9BnA3e3PWzyat
         ZDaH56MU1TiPT5VaerJbSgpcMcFqNQBrjKLUs6BZcs/DlMFtNYh6s7hghmSaWywrBf
         u93y5R1QKhFo3jr34pnZRAB9AIGzj9sPbcvZzIaROWBClyMqHAOiOG5Rxt1EPKGevr
         PCAmKIVt5dP7g==
Message-ID: <2e840ad028869edeb4238869eca81593820688b1.camel@kernel.org>
Subject: missing patches for v6.6-rc
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Dai Ngo <dai.ngo@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Tue, 10 Oct 2023 08:49:35 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

There are a couple of client side patches that I think we want in v6.6,
but that haven't shown up in linux-next yet. Do you still plan to take
these from Dai and Scott?

    [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
    [PATCH v3 1/1] nfs42: client needs to strip file mode's suid/sgid bit a=
fter ALLOCATE op

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
