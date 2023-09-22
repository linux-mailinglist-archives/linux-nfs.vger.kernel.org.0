Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE17AB9F4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjIVTUS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTUR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 15:20:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC112A3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 12:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F64EC433C7;
        Fri, 22 Sep 2023 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410411;
        bh=OK67HvpEuf6TEB7WxwUhlXvOpINXLHYzkGTkieg2r9o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u0/blctRV+J+nKRgekP6qSzNa8fgT14WezbaERzlESxPvuB0HhTC73HvFhww6NFIg
         D22km6uw5hFFa2CFyYbxLejlkCIlmCS+Ot3o478Ep3anWXWX4xMmLaZZLIgOBXI1mu
         3dbst6uLFmbvrS6D46t72s1cp2nRo4WBihsBl5xzEyFCa9S6VD/1rWGdAxQDIRQLvd
         htiXGrcB8P1K3gYHw9vrXRwMQl/AvfR9BpqDxIsnihO0u/p6ivYWsWjEWOI0mBvcIn
         rusjra66jQOTHOcY+/CUcV4T0KskBrHStredPk7mR0PD3JrV3g3bnTITSafzXSLvRS
         x3NHU+cFxRvaQ==
Message-ID: <f789565ea0cbd74ba07da026c2e1907d759e598d.camel@kernel.org>
Subject: Re: [PATCH v1 00/52] Modernize nfsd4_encode_fattr()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 22 Sep 2023 15:20:09 -0400
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-18 at 09:56 -0400, Chuck Lever wrote:
> This series restructures the server's fattr4 encoder. It is largely
> a maintenance improvement (ie, only 2nd-order benefits). There are
> no new features or performance benefits, and I hope there will be no
> changes in behavior.
>=20
> The goals:
> * Better alignment with spec
> * Easier to read and audit
> * Less brittle
> * Some code de-duplication
>=20
> This series applies to v6.6-rc2. Minor adjustment will be needed to
> apply it to nfsd-next. I apologize for the number of patches, but
> each of them (with only a couple of exceptions) is small and
> mechanical, and therefore easily digested.
>=20
> A branch containing these patches is available in this repo:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> See the "nfsd4-encoder-overhaul" branch.
>=20
> ---
>=20
> Chuck Lever (52):
>       NFSD: Add simple u32, u64, and bool encoders
>       NFSD: Rename nfsd4_encode_bitmap()
>       NFSD: Clean up nfsd4_encode_setattr()
>       NFSD: Add struct nfsd4_fattr_args
>       NFSD: Add nfsd4_encode_fattr4__true()
>       NFSD: Add nfsd4_encode_fattr4__false()
>       NFSD: Add nfsd4_encode_fattr4_supported_attrs()
>       NFSD: Add nfsd4_encode_fattr4_type()
>       NFSD: Add nfsd4_encode_fattr4_fh_expire_type()
>       NFSD: Add nfsd4_encode_fattr4_change()
>       NFSD: Add nfsd4_encode_fattr4_size()
>       NFSD: Add nfsd4_encode_fattr4_fsid()
>       NFSD: Add nfsd4_encode_fattr4_lease_time()
>       NFSD: Add nfsd4_encode_fattr4_rdattr_error()
>       NFSD: Add nfsd4_encode_fattr4_aclsupport()
>       NFSD: Add nfsd4_encode_nfsace4()
>       NFSD: Add nfsd4_encode_fattr4_acl()
>       NFSD: Add nfsd4_encode_fattr4_filehandle()
>       NFSD: Add nfsd4_encode_fattr4_fileid()
>       NFSD: Add nfsd4_encode_fattr4_files_avail()
>       NFSD: Add nfsd4_encode_fattr4_files_free()
>       NFSD: Add nfsd4_encode_fattr4_files_total()
>       NFSD: Add nfsd4_encode_fattr4_fs_locations()
>       NFSD: Add nfsd4_encode_fattr4_maxfilesize()
>       NFSD: Add nfsd4_encode_fattr4_maxlink()
>       NFSD: Add nfsd4_encode_fattr4_maxname()
>       NFSD: Add nfsd4_encode_fattr4_maxread()
>       NFSD: Add nfsd4_encode_fattr4_maxwrite()
>       NFSD: Add nfsd4_encode_fattr4_mode()
>       NFSD: Add nfsd4_encode_fattr4_numlinks()
>       NFSD: Add nfsd4_encode_fattr4_owner()
>       NFSD: Add nfsd4_encode_fattr4_owner_group()
>       NFSD: Add nfsd4_encode_fattr4_rawdev()
>       NFSD: Add nfsd4_encode_fattr4_space_avail()
>       NFSD: Add nfsd4_encode_fattr4_space_free()
>       NFSD: Add nfsd4_encode_fattr4_space_total()
>       NFSD: Add nfsd4_encode_fattr4_space_used()
>       NFSD: Add nfsd4_encode_fattr4_time_access()
>       NFSD: Add nfsd4_encode_fattr4_time_create()
>       NFSD: Add nfsd4_encode_fattr4_time_delta()
>       NFSD: Add nfsd4_encode_fattr4_time_metadata()
>       NFSD: Add nfsd4_encode_fattr4_time_modify()
>       NFSD: Add nfsd4_encode_fattr4_mounted_on_fileid()
>       NFSD: Add nfsd4_encode_fattr4_fs_layout_types()
>       NFSD: Add nfsd4_encode_fattr4_layout_types()
>       NFSD: Add nfsd4_encode_fattr4_layout_blksize()
>       NFSD: Add nfsd4_encode_fattr4_suppattr_exclcreat()
>       NFSD: Add nfsd4_encode_fattr4_sec_label()
>       NFSD: Add nfsd4_encode_fattr4_xattr_support()
>       NFSD: Copy FATTR4 bit number definitions from RFCs
>       NFSD: Use a bitmask loop to encode FATTR4 results
>       NFSD: Rename nfsd4_encode_fattr()
>=20
>=20
>  fs/nfsd/nfs4xdr.c        | 1419 +++++++++++++++++++++-----------------
>  fs/nfsd/nfsfh.c          |    2 +-
>  fs/nfsd/nfsfh.h          |    3 +-
>  fs/nfsd/xdr4.h           |  119 ++++
>  include/linux/iversion.h |    2 +-
>  include/linux/nfs4.h     |  260 +++++--
>  6 files changed, 1085 insertions(+), 720 deletions(-)
>=20
> --
> Chuck Lever
>=20

Large set, but the change is fairly mechanical overall, and the result
is much more readable.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
