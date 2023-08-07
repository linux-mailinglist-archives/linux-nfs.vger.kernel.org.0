Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24FB771DC3
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHGKId (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 06:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjHGKIc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 06:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA110EA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 03:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE6D6176A
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 10:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786D8C433C8;
        Mon,  7 Aug 2023 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691402910;
        bh=9wlWnzyk08pdNHhazzGurJuaJkJDCDJfXEzaPFNX6vE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ERMWw7ZaDU/td/8Xwc0YrcQi9O18ctIH+nOWlGvGJpL2cHK5W+4qDbnIHeyR4P+1x
         jfeSYE9292LVAqahsbCEpc3u3WKfb2mz9hQYihrN1oXCtFhbLmYfJRIepkwVoKUs/d
         DnxplNNNq/O2WTPR2vtcIiu3VnHvK+wU4B2oljmP/42ZGyvVqAMaF6pl0yWFpU732y
         joNauEsfEqPixI/nghAVFDtXNYAri6ZsguULL94SKliiCdx6WC0FE+hUBxw0WkMpsY
         1ubLIZUv6G+WfmVEc2BmMFqcaC178hVQ9niEUC46TIgOLiF5D6pKNbFmEnPrOBgaO0
         XMSZ/Ca/KjyHg==
Message-ID: <6461e16380ad638547f6db3af4aa873a490d9fa3.camel@kernel.org>
Subject: Re: [PATCH v5 0/2] add rpc_status handler in nfsd debug filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de
Date:   Mon, 07 Aug 2023 06:08:28 -0400
In-Reply-To: <cover.1691169103.git.lorenzo@kernel.org>
References: <cover.1691169103.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-08-04 at 19:16 +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
>=20
> Changes since v4:
> - rely on acquire/release APIs and get rid of atomic operation
> - fix kdoc for nfsd_rpc_status_open
> - get rid of ',' as field delimiter in nfsd_rpc_status hanlder
> - move nfsd_rpc_status before nfsd_v4 enum entries
> - fix compilantion error if nfsdv4 is not enabled
>=20
> Changes since v3:
> - introduce rq_status_counter in order to detect if the RPC request is
>   pending and RPC info are stable
> - rely on __svc_print_addr to dump IP info
>=20
> Changes since v2:
> - minor changes in nfsd_rpc_status_show output
>=20
> Changes since v1:
> - rework nfsd_rpc_status_show output
>=20
> Changes since RFCv1:
> - riduce time holding nfsd_mutex bumping svc_serv refcoung in
>   nfsd_rpc_status_open()
> - dump rqstp->rq_stime
> - add missing kdoc for nfsd_rpc_status_open()
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D3D366
>=20
> Lorenzo Bianconi (2):
>   SUNRPC: add verbose parameter to __svc_print_addr()
>   NFSD: add rpc_status entry in nfsd debug filesystem
>=20
>  fs/nfsd/nfs4proc.c              |   4 +-
>  fs/nfsd/nfsctl.c                |   9 ++
>  fs/nfsd/nfsd.h                  |   7 ++
>  fs/nfsd/nfssvc.c                | 140 ++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h      |   1 +
>  include/linux/sunrpc/svc_xprt.h |  12 +--
>  net/sunrpc/svc.c                |   2 +-
>  net/sunrpc/svc_xprt.c           |   2 +-
>  8 files changed, 166 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
