Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE646753BC5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjGNN0H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 09:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGNN0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 09:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6EC1B6
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 06:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F32F61CCF
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 13:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A0CC433C7;
        Fri, 14 Jul 2023 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689341165;
        bh=bHzTzZjUxgGtmlMGY594nvqgU3IccRmVn9IFpteYwVA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=byBEoAQ1dknOTesT4zavdnHXDizZXQGHjrmIFXe22AhrUcsixVGkg/tKrHEmuzhfR
         GcJCg153p+2ycBbJ5ZFajGXXWFvRUK9Qn1aL/a88c/e3w6jSZjFO38+DdWKHK9tw68
         bacbg4Y8+KlVx981sO9qWFaDSrqw681BSmQAf7A2SrV1oaE2jrXUB3ubFPOhOr9rxE
         PB3SXjKfyS2pgHDS/ODghHft4HjFCe6Ez0PaQm4Vj/J2SDD/fjxcRpjnb3izo5Rg+L
         ahU43LmS0tGZuU/R/W2zveP2b3E9WJf4YotZJbsjvmpbiyUh7OLRHvpq+NhCffArtv
         A0MGQbkxoyn8w==
Message-ID: <3376204b7b0335721956c45f22b10a2ff41aa276.camel@kernel.org>
Subject: Re: [PATCH RFC 0/4] Send RPC-on-TCP with one sock_sendmsg() call
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        David Howells <dhowells@redhat.com>
Date:   Fri, 14 Jul 2023 09:26:03 -0400
In-Reply-To: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-07-09 at 16:04 -0400, Chuck Lever wrote:
> After some discussion with David Howells at LSF/MM 2023, we arrived
> at a plan to use a single sock_sendmsg() call for transmitting an
> RPC message on socket-based transports. This is an initial part of
> the transition to support handling folios with file content, but it
> has scalability benefits as well.
>=20
> Comments, suggestions, and test results are welcome.
>=20
> ---
>=20
> Chuck Lever (4):
>       SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
>       SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec arra=
y
>       SUNRPC: Use a per-transport receive bio_vec array
>       SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
>=20
>=20
>  include/linux/sunrpc/svc.h     |   1 -
>  include/linux/sunrpc/svcsock.h |   7 ++
>  net/sunrpc/svcsock.c           | 142 ++++++++++++++++++---------------
>  3 files changed, 86 insertions(+), 64 deletions(-)
>=20
> --
> Chuck Lever
>=20

Aside from my concerns with bounds checking on the first patch, this
looks like a good set of changes overall. Does it show any performance
improvements in your testing?
--=20
Jeff Layton <jlayton@kernel.org>
