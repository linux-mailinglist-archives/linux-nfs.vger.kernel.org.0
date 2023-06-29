Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494CE7428DA
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF2OvQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2OvP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 10:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDF1FC1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 07:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2055861561
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 14:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E62C433C8;
        Thu, 29 Jun 2023 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688050273;
        bh=02t0CZdC7KSE9b2HUjz/s9neh4lYgdiEDTUeO3YDVYk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kHtddUjtrzpH1OzFoDMnVATjeLk3HrSBTCyXA4DkQHjy6wDMMEcQOy0ZPtCWQRv79
         538IqY8Xa2CM7I2plXzx1SP2WLqeq1w1//LtNIbmNds3/4lSJLsvJm4Lobr1ZZpjVR
         DlTf6t96lCYDyb1wJp/GkAiZ3ERtOPaM8MTB7DIojIScRKV8AE7+C17py+41Pj4sAT
         /TabTefrycEouGJh1AuVsiVJmIakcDLsZqYREMkJQn45veuk7qswUrupA1JfSB6bT1
         iiED3I5iFi3y4J69sT1JCAuGDUq6MoSVBdqgqsOdya8FIjQxdCmFm6lP1IyMhY+Eui
         02JDl6zYoLe0w==
Message-ID: <b3bd9112483c70bfb54ee0c08b807cc94c841c96.camel@kernel.org>
Subject: Re: [PATCH v6 0/5] NFSD: add support for NFSv4.1+ write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 29 Jun 2023 10:51:11 -0400
In-Reply-To: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-06-28 at 19:36 -0700, Dai Ngo wrote:
> The NFSv4 server currently supports read delegation using VFS lease
> which is implemented using file_lock.=20
>=20
> This patch series add write delegation support for NFSv4.1+ client by:
>=20
>     . remove the check for F_WRLCK in generic_add_lease to allow
>       file_lock to be used for write delegation. =20
>=20
>     . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>       if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change, try_break_de=
leg.
>=20
> The write delegation support is for NFSv4.1+ client only since the NFSv4.=
0
> Linux client behavior is not compliant with RFC 7530 Section 16.7.5. It
> expects the server to look ahead in the compound to find a stateid in ord=
er
> to determine whether the client that sends the GETATTR is the same client
> that holds the write delegation. RFC 7530 spec does not call for the serv=
er
> to look ahead in order to service the GETATTR op.
>=20
> Changes since v1:
>=20
> [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
> - remove WARN_ON_ONCE from encode_bitmap4
> - replace decode_bitmap4 with xdr_stream_decode_uint32_array
> - replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
>    with xdr_stream_decode_u64. Also remove the un-needed likely().
> - modify signature of encode_cb_getattr4args to take pointer to
>    nfs4_cb_fattr
> - replace decode_attr_length with xdr_stream_decode_u32
> - rename decode_cb_getattr to decode_cb_fattr4
> - fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
> - rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>   in fs/nfsd/nfs4xdr.c
> - correct NFS4_dec_cb_getattr_sz and update size description
>=20
> [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
> - change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
> - change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>   in fs/nfsd/nfs4xdr.c
>=20
> Changes since v2:
>=20
> [PATCH 2/4] NFSD: enable support for write delegation
> - rename 'deleg' to 'dl_type' in nfs4_set_delegation
> - remove 'wdeleg' in nfs4_open_delegation
>=20
> - drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
>   and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
>   for futher clarification of the benefits of these patches
>=20
> Changes since v3:
>=20
> - recall write delegation when there is GETATTR from 2nd client
> - add trace point to track when write delegation is granted=20
>=20
> Changes since v4:
> - squash 4/4 into 2/4
> - apply 1/4 last instead of first
> - combine nfs4_wrdeleg_filelock and nfs4_handle_wrdeleg_conflict to
>   nfsd4_deleg_getattr_conflict and move it to fs/nfsd/nfs4state.c
> - check for lock belongs to delegation before proceed and do it
>   under the fl_lock
> - check and skip FL_LAYOUT file_locks
>=20
> Changes since v5:
> - [patch 2/5] disable write delegation for NFSv4.0 client
>=20
> - [patch 4/5] allow client to use write delegation stateid for READ (same
>   behavior as Solaris server)
>=20
>   When the server receives a READ request with write delegation stateid
>   the server may returns the NFS4ERR_OPENMODE or allows the READ to proce=
ed
>   to accommodate clients whose WRITE implementation may unavoidably do re=
ads
>   (e.g., due to buffer cache constraints).  Per RFC 8881 section 9.1.2. U=
se
>   of the Stateid and Locking
>=20
>   Returning NFS4ERR_OPENMODE causes the client and server to enter an inf=
inite
>   loop of READ, NFS4ERR_OPENMODE, TEST_STATEID, READs, NFS4ERR_OPENMODEs,
>   TEST_STATEID, READs, NFS4ERR_OPENMODEs. The Linux NFS client can not re=
cover
>   from NFS4ERR_OPENMODE for READ request if the file was opened with
>   OPEN4_SHARE_ACCESS_WRITE. This READ was initiated internally from the N=
FS
>   client and not from the read(2) system call.
>=20
> - pass git regression test with 40 threads
>=20

Nice work, Dai! This all looks good to me. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
