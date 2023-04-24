Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D06ECFE4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDXODY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 10:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDXODX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 10:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825E6190
        for <linux-nfs@vger.kernel.org>; Mon, 24 Apr 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682344949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRwwwbGR5xT5WLBTq5Flf0ak6dZbAh3W+eAZv1Rax00=;
        b=IL11ekIlIrDywosCP8XLPSs+OsjkF56PQVd4vIgnGvwSyLDnSSCvmHxlFp/j3Arh7eZI7g
        odrtWi9rySQPcurtkkd3G3GpmaLjFQE9dJ23dMrjWC6poTKodowXaMCM2vs95bTfi8F+0R
        Xiz91VYxBY50y4OjqePqRkGKLvoIA80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-z5WpnSx0OjSLj0o0neM7dQ-1; Mon, 24 Apr 2023 10:02:26 -0400
X-MC-Unique: z5WpnSx0OjSLj0o0neM7dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4BFF101A552;
        Mon, 24 Apr 2023 14:02:25 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A53E82027043;
        Mon, 24 Apr 2023 14:02:25 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 3416B1A27F5; Mon, 24 Apr 2023 10:02:25 -0400 (EDT)
Date:   Mon, 24 Apr 2023 10:02:25 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Message-ID: <ZEaL8Wueo5/vOGTg@aion.usersys.redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
 <20230420202004.239116-6-smayhew@redhat.com>
 <20230422212710.GA813856@farprobe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422212710.GA813856@farprobe>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 22 Apr 2023, Ben Boeckel wrote:

> On Thu, Apr 20, 2023 at 16:20:04 -0400, Scott Mayhew wrote:
> > This patch adds the option to store GSS credentials in keyrings as an
> > alternative to the RPC credential cache, to give users the ability to
> > destroy their GSS credentials on demand via 'keyctl unlink'.
> 
> Can documentation please be added to `Documentation/security/keys` about
> this key type?

I'll work on that.

> 
> > Summary of the changes:
> > 
> > - Added key_type key_type_gss_cred and associated functions.  The
> >   request_key function makes use of the existing upcall mechanism to
> >   gssd.
> > 
> > - Added a keyring to the gss_auth struct to allow all of the assocated
> >   GSS credentials to be destroyed on RPC client shutdown (when the
> >   filesystem is unmounted).
> > 
> > - The key description contains the RPC client id, the user id, and the
> >   principal (for machine creds).
> 
> What is the format of this within the bytes?

The format is "clid: <client-id> id: <fsuid> princ:<princ>", where
client-id and fsuid are unsigned ints and princ is either "(none)" or
"*" if it's a machine cred:

crash> p ((struct key *) 0xffff8b4410197900)->description
$1 = 0xffff8b4446cbd740 "clid:1 id:1000 princ:(none)"

> 
> > - The key payload contains the address of the gss_cred.
> 
> What is the format of this within the bytes?

The payload is just a pointer:

crash> p ((struct key *) 0xffff8b4410197900)->payload.data[0]
$2 = (void *) 0xffff8b44381cd480

> 
> > - The key is linked to the user's user keyring (KEY_SPEC_USER_KEYRING)
> >   as well as to the keyring on the gss_auth struct.
> 
> Where is this documented? Can the key be moved later?

It's not - I can add that to the documentation for the new key type.
The key should not be moved.  I haven't tested if it's possible to move
it, but it's something that we'd want to disallow.

-Scott
> 
> > - gss_cred_init() now takes an optional pointer to an authkey, which is
> >   passed down to gss_create_upcall() and gss_setup_upcall(), where it is
> >   added to the gss_msg.  This is used for complete_request_key() after
> >   the upcall is done.
> > 
> > - put_rpccred() now returns a bool to indicate whether it called
> >   crdestroy(), and is used by gss_key_revoke() and gss_key_destroy() to
> >   determine whether to clear the key payload.
> > 
> > - gss_fill_context() now returns the GSS context's timeout via the tout
> >   parameter, which is used to set the timeout of the key.
> > 
> > - Added the module parameter 'use_keyring'.  When set to true, the GSS
> >   credentials are stored in the keyrings.  When false, the GSS
> >   credentials are stored in the RPC credential caches.
> > 
> > - Added a tracepoint to log the result of the key request, which prints
> >   either the key serial or an error return value.
> > 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  include/linux/sunrpc/auth.h    |   4 +-
> >  include/trace/events/rpcgss.h  |  46 ++++-
> >  net/sunrpc/auth.c              |   9 +-
> >  net/sunrpc/auth_gss/auth_gss.c | 338 +++++++++++++++++++++++++++++++--
> >  4 files changed, 376 insertions(+), 21 deletions(-)
> 
> Thanks,
> 
> --Ben
> 

