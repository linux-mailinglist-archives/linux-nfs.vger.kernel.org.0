Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D49779161
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 16:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHKOGz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjHKOGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 10:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7EEA
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 07:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBE760F4B
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 14:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D28C433C7;
        Fri, 11 Aug 2023 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691762813;
        bh=rjoXSWhr5PpJOP959RUInL/N6dBmCddnze2P4T8fb78=;
        h=Subject:From:To:Cc:Date:From;
        b=cjOrcsxx1cxd2CBPpRPo/F/rvVWycrgvuTIukZAT+I9x9lzrtt8E3n9BdtFQQwaWS
         vkgWV0lHPFSkSXACKIq8VuC4DwGCrzjEbuj5/6VQ9YwkyBRiSXBnXxR8JOWYtVtcki
         EqBcJCL/oosaoZDdU9ELyyzl7jTrfXIAMfDHGM9bkHgnGnPd/FdWxNxfSxRripPsrS
         pNrwrPvCWbdr6aA5MgjG1JWheCrTHK4oHtr8iuiWOrslgRVWg7NDqXRoHiLbJCZrJL
         1qaAtU6xAU6ETgg+G4hsMliN/J+qf0QsCAaXjqH55JiZd5TprkXHbkXzaJHVh0NYxY
         AEN4QpG3Cp8Uw==
Message-ID: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org>
Subject: turning on s2s copy by default in knfsd
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Date:   Fri, 11 Aug 2023 10:06:51 -0400
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck and I were chatting yesterday about what it will take to make the
inter_copy_offload_enable module option on by default, and I'd like to
start working toward that end.

I think what we want to aim for is to eventually deprecate the module
option and have this "just work" when the conditions are right.

It looks like main obstacle is this (from RFC7862 section 4.9):

   NFSv4 clients and servers supporting the inter-server COPY operations
   described in this section are REQUIRED to implement the mechanism
   described in Section 4.9.1.1 and to support rejecting COPY_NOTIFY
   requests that do not use the RPC security protocol (RPCSEC_GSS)
   [RFC7861] with privacy.  If the server-to-server copy protocol is
   based on ONC RPC, the servers are also REQUIRED to implement
   [RFC7861], including the RPCSEC_GSSv3 "copy_to_auth",
   "copy_from_auth", and "copy_confirm_auth" structured privileges.
   This requirement to implement is not a requirement to use; for
   example, a server may, depending on configuration, also allow
   COPY_NOTIFY requests that use only AUTH_SYS.

   If a server requires the use of an RPCSEC_GSSv3 copy_to_auth,
   copy_from_auth, or copy_confirm_auth privilege and it is not used,
   the server will reject the request with NFS4ERR_PARTNER_NO_AUTH.

We don't (yet) have GSSv3 support, so we'd need to implement that in
order to make this work right with krb5. Has anyone started looking at
GSSv3?

Incidentally, has anyone tried doing this with sec=3Dkrb5 in the current
code? Does it actually work? I don't see any place where we return
nfserr_partner_no_auth, so I wonder if we need to fix up the s2s COPY
authentication and error handling?

Another question: The v4.2 spec was written before the RPC over TLS
spec. Should we aim to allow this to work by default if the client and
both servers are using xprtsec=3Dmtls and are secured by the same CA?

1/ the client and servers are all using GSSv3 with krb5p (or some other
encryption)

...or...

2/ the client and servers are all using mtls with certificates signed by
the same CA


...I expect we'll probably be able to accomodate #2 before #1.

Beyond that, we could allow for module or export option that still
allows s2s copy to work and relaxes the above restrictions (to allow
people to use it over plaintext with AUTH_SYS on "secure" networks).

Anything I've overlooked here, or other thoughts?

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
