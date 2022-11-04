Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA01619669
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKDMpE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKDMpE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 08:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558746258
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 05:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D220A62181
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 12:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5070C433C1;
        Fri,  4 Nov 2022 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667565902;
        bh=8anLVmwlMWVqPVFBugFd/vZCH4x6g/yssvZQwFtvkbU=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=KoYya9rv2e8bk1SyB3bYHZOt0JV6ByuCIKCVuQKLFljhkDuDHWCbW+bOUOLjW9ZVN
         q5NkBR1RD1OPb31UHn8zJkJsFjxSjU+NHpjEX655UNgYPAD0SiSLji47xHduVWnC4N
         SAxOQHeU3yVaJWnNBWnwm0cy+NGfFpOvmSyXvda03AqtsdV5iCj0pr+NKIfsolhALm
         8jW60Ag1n4jV1QKzlyTOiBHdp4/Sj8yHS9bSWL7qgEoZpGEjETqLmjueJCFvc4JKnp
         7WFVbbD9xvogmBluC5/uHLXMan4uBffM7tlaqh5CWVyt6+fciLWW+c5igZs5AJ8Qxv
         7kwLYRemn5adA==
Message-ID: <e4271851b66a15547c696462fad280260f924cef.camel@kernel.org>
Subject: Re: [PATCH v1 0/2] A couple of tracepoint updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 04 Nov 2022 08:45:00 -0400
In-Reply-To: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
References: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-11-03 at 16:22 -0400, Chuck Lever wrote:
> These apply on top of Jeff's reference counting update.
>=20
> ---
>=20
> Chuck Lever (2):
>       NFSD: Add an nfsd_file_fsync tracepoint
>       NFSD: Re-arrange file_close_inode tracepoints
>=20
>=20
>  fs/nfsd/filecache.c | 22 ++++++-------
>  fs/nfsd/trace.h     | 76 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 57 insertions(+), 41 deletions(-)
>=20
> --
> Chuck Lever
>=20

These look fine to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
