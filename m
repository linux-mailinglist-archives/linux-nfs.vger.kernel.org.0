Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131B7A4ECB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIRQ06 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIRQ0Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:26:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45FD282B7
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:23:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B1DC433B6;
        Mon, 18 Sep 2023 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045408;
        bh=dQJeM9YgMqokf6Vk+HE1/z4jNWMeQ3bLqeKjuu6O9s4=;
        h=Subject:From:To:Cc:Date:From;
        b=WAmhYe3hSx/HnkXk30CSvzLBceEtsDY2MfEwMVJFDimytfaifnnalI8Pq49Ec27xi
         wb0RzFT/sHh1g+m/0pMdVffGrWUMjteUlzpUli9XIuT2q4p3acKJ2p/YUtojNAVHGc
         ACJPv8rU6ewMUqd+Qg1O3E1nbpw1H4G1LTXP/zQd3mgtgviQy3RpWeXhmpssGk6AMb
         w3WuGrgW/XBLOfSeyMSPg9j6g3ikIFuD0WGMkHeC7ZDr+pyTel4t0wVs9nqNrRoJXX
         HaI00ROX42mXQh0E4wr+YOxQTUFXL6hq6IItdhBUch5cKeE00RDdvY+4qEvmfMd/K+
         00oshMYC8nukg==
Subject: [PATCH v1 00/52] Modernize nfsd4_encode_fattr()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:56:47 -0400
Message-ID: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series restructures the server's fattr4 encoder. It is largely
a maintenance improvement (ie, only 2nd-order benefits). There are
no new features or performance benefits, and I hope there will be no
changes in behavior.

The goals:
* Better alignment with spec
* Easier to read and audit
* Less brittle
* Some code de-duplication

This series applies to v6.6-rc2. Minor adjustment will be needed to
apply it to nfsd-next. I apologize for the number of patches, but
each of them (with only a couple of exceptions) is small and
mechanical, and therefore easily digested.

A branch containing these patches is available in this repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

See the "nfsd4-encoder-overhaul" branch.

---

Chuck Lever (52):
      NFSD: Add simple u32, u64, and bool encoders
      NFSD: Rename nfsd4_encode_bitmap()
      NFSD: Clean up nfsd4_encode_setattr()
      NFSD: Add struct nfsd4_fattr_args
      NFSD: Add nfsd4_encode_fattr4__true()
      NFSD: Add nfsd4_encode_fattr4__false()
      NFSD: Add nfsd4_encode_fattr4_supported_attrs()
      NFSD: Add nfsd4_encode_fattr4_type()
      NFSD: Add nfsd4_encode_fattr4_fh_expire_type()
      NFSD: Add nfsd4_encode_fattr4_change()
      NFSD: Add nfsd4_encode_fattr4_size()
      NFSD: Add nfsd4_encode_fattr4_fsid()
      NFSD: Add nfsd4_encode_fattr4_lease_time()
      NFSD: Add nfsd4_encode_fattr4_rdattr_error()
      NFSD: Add nfsd4_encode_fattr4_aclsupport()
      NFSD: Add nfsd4_encode_nfsace4()
      NFSD: Add nfsd4_encode_fattr4_acl()
      NFSD: Add nfsd4_encode_fattr4_filehandle()
      NFSD: Add nfsd4_encode_fattr4_fileid()
      NFSD: Add nfsd4_encode_fattr4_files_avail()
      NFSD: Add nfsd4_encode_fattr4_files_free()
      NFSD: Add nfsd4_encode_fattr4_files_total()
      NFSD: Add nfsd4_encode_fattr4_fs_locations()
      NFSD: Add nfsd4_encode_fattr4_maxfilesize()
      NFSD: Add nfsd4_encode_fattr4_maxlink()
      NFSD: Add nfsd4_encode_fattr4_maxname()
      NFSD: Add nfsd4_encode_fattr4_maxread()
      NFSD: Add nfsd4_encode_fattr4_maxwrite()
      NFSD: Add nfsd4_encode_fattr4_mode()
      NFSD: Add nfsd4_encode_fattr4_numlinks()
      NFSD: Add nfsd4_encode_fattr4_owner()
      NFSD: Add nfsd4_encode_fattr4_owner_group()
      NFSD: Add nfsd4_encode_fattr4_rawdev()
      NFSD: Add nfsd4_encode_fattr4_space_avail()
      NFSD: Add nfsd4_encode_fattr4_space_free()
      NFSD: Add nfsd4_encode_fattr4_space_total()
      NFSD: Add nfsd4_encode_fattr4_space_used()
      NFSD: Add nfsd4_encode_fattr4_time_access()
      NFSD: Add nfsd4_encode_fattr4_time_create()
      NFSD: Add nfsd4_encode_fattr4_time_delta()
      NFSD: Add nfsd4_encode_fattr4_time_metadata()
      NFSD: Add nfsd4_encode_fattr4_time_modify()
      NFSD: Add nfsd4_encode_fattr4_mounted_on_fileid()
      NFSD: Add nfsd4_encode_fattr4_fs_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_blksize()
      NFSD: Add nfsd4_encode_fattr4_suppattr_exclcreat()
      NFSD: Add nfsd4_encode_fattr4_sec_label()
      NFSD: Add nfsd4_encode_fattr4_xattr_support()
      NFSD: Copy FATTR4 bit number definitions from RFCs
      NFSD: Use a bitmask loop to encode FATTR4 results
      NFSD: Rename nfsd4_encode_fattr()


 fs/nfsd/nfs4xdr.c        | 1419 +++++++++++++++++++++-----------------
 fs/nfsd/nfsfh.c          |    2 +-
 fs/nfsd/nfsfh.h          |    3 +-
 fs/nfsd/xdr4.h           |  119 ++++
 include/linux/iversion.h |    2 +-
 include/linux/nfs4.h     |  260 +++++--
 6 files changed, 1085 insertions(+), 720 deletions(-)

--
Chuck Lever

