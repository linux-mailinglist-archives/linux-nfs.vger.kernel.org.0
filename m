Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECC5A7AC7
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 12:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiHaKA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiHaKAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 06:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4A6B140
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 03:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37C660022
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 10:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7155C433D6;
        Wed, 31 Aug 2022 10:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661940026;
        bh=E8Mlr+2QmDfQQTay2mfw0YNxAMkEwtsGCXxUdyRwtDo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dEGfEHX4v1JJXf+vbdmW2eXzJblWHQJTx3DXZ19cUwwNKFiikILbcSE7tyroVvVih
         mFVgpoQs0wVw6Ty/ripciT7beYrdRLQK6QLey49LkT9JfRTRoxnVeMx7dLpnW9leU1
         a7T8QvSXkKgXTw6TYp2BhqNLW17ggAX5hrTat7T4UMb7vpFykfyNfQmOjjlmQcT32G
         VWYH8vMte/rEs8Jz7tjeEvUcPFlmZr1u5q1K5MLaoPJ8+Z/6oI6TInCjEVZx3Ftl04
         3sqw819nLOI2+ZQTrkYsioIJGT5YnXcPiJsC03Bg5GGI14y/1uMcob+4rTkVKK+cfb
         OteS3HUBSaS5g==
Message-ID: <a3d5fb640e1614d20ba29d14f4a4ef5b3aa2b266.camel@kernel.org>
Subject: Re: [PATCH v4 0/2] NFSD: memory shrinker for NFSv4 clients
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 31 Aug 2022 06:00:24 -0400
In-Reply-To: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-08-30 at 14:48 -0700, Dai Ngo wrote:
> This patch series implements the memory shrinker for NFSv4 clients
> to react to system low memory condition.
>=20
> The memory shrinker's count callback is used to trigger the laundromat.
> The actual work of destroying the expired clients is done by the
> laundromat itself. We can not destroying the expired clients on the
> memory shrinler's scan callback context to avoid possible deadlock.
>=20
> By destroying the expired clients, all states associated with these
> clients are also released.
>=20
> v2:
> . fix kernel test robot errors in nfsd.h when CONFIG_NFSD_V4 not defined.
>=20
> v3:
> . add mod_delayed_work in nfsd_courtesy_client_scan to kick start
>   the laundromat.
>=20
> v4:
> . replace the use of xchg() with vanilla '=3D' in patch 1.
>=20
> ---
>=20
> Dai Ngo (2):
>       NFSD: keep track of the number of courtesy clients in the system
>       NFSD: add shrinker to reap courtesy clients on low memory condition
>=20
>  fs/nfsd/netns.h     |  5 ++++
>  fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++++++++++++++++++---=
-
>  fs/nfsd/nfsctl.c    |  6 +++--
>  fs/nfsd/nfsd.h      |  9 +++++--
>  4 files changed, 76 insertions(+), 9 deletions(-)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
