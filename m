Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBB56B308
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jul 2022 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiGHHCH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jul 2022 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGHHCG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jul 2022 03:02:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684174DC4
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jul 2022 00:02:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBD751FDC3;
        Fri,  8 Jul 2022 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657263724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6i3JFbkTEXOkxnH6W0FHHFcLcJ4cy5y0a8EWZwO7qo=;
        b=AjSsvbL4VSD3UoGr8xujAzA4ralvgDJrERW866skXVD8WG8iRHVkCBx+lZquY3FKotj8of
        eS/elHuvANRm1DvXHQvZ9gcMti7MOUCSzguUL4BqF/wSttXMFWIvkw5gzHYvae0n0ajJAK
        e9cHiYhQbA1Io4ESbbxzikC2TPXn/O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657263724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6i3JFbkTEXOkxnH6W0FHHFcLcJ4cy5y0a8EWZwO7qo=;
        b=rYDSBvtSgOCnf3/988vhz4ZV+ZRSWMqesQWAiluxeJdO7Qd7O7P3nHmPKb9tqqODZMX0Ux
        eSU7LKgjVqAqoWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9828213A7D;
        Fri,  8 Jul 2022 07:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RWRoFGvWx2IbBwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 08 Jul 2022 07:02:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Problem with providing implementation id in NFSv4.1
In-reply-to: <9058936794e86fc3913046682ad35e38d89e053f.camel@hammerspace.com>
References: <165715642317.17141.14223480428236658557@noble.neil.brown.name>,
 <9058936794e86fc3913046682ad35e38d89e053f.camel@hammerspace.com>
Date:   Fri, 08 Jul 2022 17:01:48 +1000
Message-id: <165726370886.17141.15104062573305176746@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 07 Jul 2022, Trond Myklebust wrote:
> On Thu, 2022-07-07 at 11:13 +1000, NeilBrown wrote:
> >=20
> > In NFSv4.1 when we EXCHANGE_ID to talk to a new server - possibly a
> > PNFS
> > Data Server that we haven't talked to before - we by default send an
> > implementation id.=C2=A0 This is created from several fields obtained from
> > utsname().
> > utsname() depends on current->nsproxy, and will crash if that is
> > NULL.
> >=20
> > When a process exits it calls, among other things,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit_task_namespaces(tsk);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit_task_work(tsk);
> >=20
> > exit_task_namespaces() will set ->nsproxy to NULL
> > exit_task_work() will run delayed work items, including fput() on all
> > files that were still open when the process exited.=C2=A0 This will cause
> > any
> > pending writes to be flushed for NFS.
> >=20
> > So if a process writes to a file on a PNFS server, exits, and the MDS
> > tells the client to send the data to a DS which it hasn't established
> > a
> > connection with before, then it will crash in encode_exchange_id().
> >=20
> > That order of calls in do_exit() is deliberate so we cannot swap them
> > - see
> > Commit: 8aac62706ada ("move exit_task_namespaces() outside of
> > exit_notify()")
> >=20
> > The options that I can see are:
> > 1/ generate the implementation-id string at mount time and keep it
> > =C2=A0=C2=A0 around much like we do for cl_owner_id
> > 2/ Check current->nsproxy in encode_exchange_id() and skip the
> > =C2=A0=C2=A0 implementation id if ->nsproxy is not available.
> > =C2=A0=C2=A0 Note that there is no risk for a race with testing ->nxproxy.
> >=20
> > Doesn't anyone have a strong opinion of which is best.=C2=A0 I'm inclined
> > to
> > go with '2', but mostly because it is less coding.
> >=20
>=20
> I'd be fine with ignoring the implementation id in that case. The
> protocol doesn't require it, so servers are expecte to be able to deal
> with that case.

Thanks for the quick reply.  I agree with you.
However it turns out that this isn't a problem in mainline.

When you close a file the ->flush() happens earlier in do_exit() and the
name spaces are still around.  However if you have a file mapped and
have dirty pages, then mainline doesn't force a flush on final unmap, or
exit of the process that had it mapped.

As I explained in
https://lore.kernel.org/all/150304037195.30218.15740287358704674869.stgit@nob=
le/

I think this is wrong, so I have an fsync() call in nfs_file_release().
This *is* run after nsproxy has been cleared.

So mainline doesn't need this fix, but I do.

Thanks,
NeilBrown
