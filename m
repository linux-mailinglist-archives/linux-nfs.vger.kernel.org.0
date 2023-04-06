Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9C6DA4E4
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Apr 2023 23:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjDFVwD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Apr 2023 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDFVwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Apr 2023 17:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9483CE
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 14:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605DB64C35
        for <linux-nfs@vger.kernel.org>; Thu,  6 Apr 2023 21:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253EFC433D2;
        Thu,  6 Apr 2023 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680817920;
        bh=F6Htyrs5w1XHen7+WnroJzBGKkT3iBeVb7zhZxSQ+g4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R8mIb1Nfm/y2IboXgIGK8qh9ed99iVv07mlH6qfHfmbxi9NZtwIT+Paa7Kt3SW82V
         DpnvmL4MIUizfI3JqXfewMutK4Zrarxy5F0XS2+sRg9/B7v1RiG13aA9v2+nHWj9ZY
         pkJzmGFN7n6ZvhOXu57v+9PMaFnRXduCj0HVjs0yxbOWhoT5LkNB7pL9j2Oqfdl0b3
         sR+7CfAoCcNma8GWsJh5OiGtDq4db0ZI9Hi/nNlGRbgDGf5yzzwd7ClQzpyYvUL53w
         eoqUn3Xa8G6IL4v9qLbyeKJgWnbulatp/aIirAL1bygQl2tq3p7zbA53GirbeJrx/L
         4nrM4yq5tuPaA==
Message-ID: <b849b95d225cd89d43d2b094d183455249309838.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 06 Apr 2023 17:51:58 -0400
In-Reply-To: <b50336cf-09a3-60a9-0100-0a25adf4ee55@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
         <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
         <182842b2-3de4-d64b-d729-f4f6c9c576d6@oracle.com>
         <ed870a33-0809-3cfd-2d5a-b97409568b97@oracle.com>
         <64c4e5c4e61962fd828bcbef79db1df6466a875d.camel@kernel.org>
         <f6c0553c49efd9e2f643240aacdea8dd1f728443.camel@kernel.org>
         <07d8f93d-c8f3-5ede-66a3-219eea0fdfe6@oracle.com>
         <F925BB7E-4E1C-48CD-A0C0-A058058E55BD@oracle.com>
         <c659b24274539086c3adad8af4c7d30cf87ee83a.camel@kernel.org>
         <b50336cf-09a3-60a9-0100-0a25adf4ee55@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-04-06 at 13:58 -0700, dai.ngo@oracle.com wrote:
> On 4/6/23 12:59 PM, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 19:43 +0000, Chuck Lever III wrote:
> > > > On Apr 6, 2023, at 3:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> > > >=20
> > > > Hi Jeff,
> > > >=20
> > > > Thank you for taking a look at the patch.
> > > >=20
> > > > On 4/6/23 11:10 AM, Jeff Layton wrote:
> > > > > On Thu, 2023-04-06 at 13:33 -0400, Jeff Layton wrote:
> > > > > > On Tue, 2023-03-14 at 09:19 -0700, dai.ngo@oracle.com wrote:
> > > > > > > On 3/8/23 11:03 AM, dai.ngo@oracle.com wrote:
> > > > > > > > On 3/8/23 10:50 AM, Chuck Lever III wrote:
> > > > > > > > > > On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com=
> wrote:
> > > > > > > > > >=20
> > > > > > > > > > Currently call_bind_status places a hard limit of 3 to =
the number of
> > > > > > > > > > retries on EACCES error. This limit was done to accommo=
date the
> > > > > > > > > > behavior
> > > > > > > > > > of a buggy server that keeps returning garbage when the=
 NLM daemon is
> > > > > > > > > > killed on the NFS server. However this change causes pr=
oblem for other
> > > > > > > > > > servers that take a little longer than 9 seconds for th=
e port mapper to
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > Actually, the EACCES error means that the host doesn't have the p=
ort
> > > > > registered.
> > > > Yes, our SQA team runs stress lock test and restart the NFS server.
> > > > Sometimes the NFS server starts up and register to the port mapper =
in
> > > > time and there is no problem but occasionally it's late coming up c=
ausing
> > > > this EACCES error.
> > > >=20
> > > > >   That could happen if (e.g.) the host had a NFSv3 mount up
> > > > > with an NLM connection and then crashed and rebooted and didn't r=
emount
> > > > > it.
> > > > can you please explain this scenario I don't quite follow it. If th=
e v3
> > > > client crashed and did not remount the export then how can the clie=
nt try
> > > > to access/lock anything on the server? I must have missing somethin=
g here.
> > > >=20
> > > > >  =20
> > Suppose you have a client with an admin that mounts a NFSv3 mount "by
> > hand" (and doesn't set up statd to run at boot time). Client requests a=
n
> > NLM lock and then reboots.
> >=20
> > When it comes up, there's no notification to the server that the client
> > rebooted. Later, the lock becomes free and the server tries to grant it
> > to the client. It talks to rpcbind but lockd is never started and the
> > server keeps querying the client's rpcbind forever.
> >=20
> > Maybe more likely situation: the client crashes and loses its DHCP
> > address when it comes back up, and the old addr gets reassigned to
> > another host that has rpcbind running but no NFS.
> >=20
> > Either way, it'd keep trying to call the client back indefinitely that
> > way.
>=20
> Got it Jeff, thank you for the explanation. This is when NLM requests
> are originated from the NFS server.
>=20

Mostly, yes. The old, stateless NFS v2/v3 server code didn't have much
in the way of callbacks, and v4 (for the most part) doesn't rely on
rpcbind.

That said, there may be some RPC calls done by the v2/3 NFS client that
don't have a direct connection to a client task. Consider stuff like
writeback requests. Signals won't do anything there.

I think keeping a hard timeout of some sort is probably prudent.

>=20
--=20
Jeff Layton <jlayton@kernel.org>
