Return-Path: <linux-nfs+bounces-12463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9EAD96DD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8867A62C8
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879627144C;
	Fri, 13 Jun 2025 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltGmLkZ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E6270EBC;
	Fri, 13 Jun 2025 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848709; cv=none; b=q+pCr2+uZF/HMzS5Q8+vnvMa2g5AOcTQ8/16TYoRu3cmMU8NeNTM6ifr12rMziO+sOkbjskLMfb+c9v0czDFeZDtNwVVxNUqP61TOrrIrYyJ+hn8dliDl8hwsgVOtwTNbMATL7OvgR4fqmRryTqXBQnnlmWJ7l016Gs0+vLpaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848709; c=relaxed/simple;
	bh=riqdrxkchD8LFwzBCMlF3Imf3FCZoNoP21Xd7szeknw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUgrD+siXLNvGF3AFzvcutLNRr5Xx6pDxyB1YrD/zo4SQte9Ac2+pIFnP06yqRaYLEp9PROWa1Ks1PO2/pi7O4j5xhTiFLKZFIKZiZi8S3gbH+oAZuzRbFLifUw9mAthUfX/GmSuXpAWx4iuC/S1YFKQj9XBdhgzQtY4ODvhhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltGmLkZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383E1C4CEEF;
	Fri, 13 Jun 2025 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749848709;
	bh=riqdrxkchD8LFwzBCMlF3Imf3FCZoNoP21Xd7szeknw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ltGmLkZ0Y0nIy9SeSra84asXfRhsLs7IwyEyvPtTomikiRhLnJp4yE/NIY2PsuiY9
	 8qXhVI0i/1Uv/7khX196sXH91ZbBW2/AiKW+rOAaiTo9KSK9XZYp2DMm2C0cRD+OFx
	 t9q16sAiBnKJcUF2Q3jZS6rIodbYcH2w71u4Lfa+Dv1zxUgREJYeCZ9Lc+VRVxdl9g
	 QyqaUFGq4YtC2LSZelNiK/rm+SEIZvJO8sYtrDjkNrg4Hn+CSXygSXqp+GhG2g3e0z
	 sJd6+4rRtq8ef5bvLd0BJxL2e2X05NEYvnuUzT7a38hPVpO7uHuGpo50tcXz0OAi7l
	 wqun6Y2YnhwwA==
Message-ID: <238e4d9decc44ed82dcba940725cbf4c6802812e.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Benjamin Coddington
	 <bcodding@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Trond Myklebust	
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman	
 <horms@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Fri, 13 Jun 2025 17:05:06 -0400
In-Reply-To: <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
	 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
	 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
	 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
	 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
	 <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
	 <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
	 <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 10:56 -0400, Chuck Lever wrote:
> On 6/13/25 7:33 AM, Benjamin Coddington wrote:
> > On 12 Jun 2025, at 12:42, Chuck Lever wrote:
> >=20
> > > On 6/12/25 12:15 PM, Jeff Layton wrote:
> > > > On Thu, 2025-06-12 at 12:05 -0400, Chuck Lever wrote:
> > > > > On 6/12/25 11:57 AM, Jeff Layton wrote:
> > > > > > On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
> > > > > > > The old nfsdfs interface for starting a server with multiple =
pools
> > > > > > > handles the special case of a single entry array passed down =
from
> > > > > > > userland by distributing the threads over every NUMA node.
> > > > > > >=20
> > > > > > > The netlink control interface however constructs an array of =
length
> > > > > > > nfsd_nrpools() and fills any unprovided slots with 0's. This =
behavior
> > > > > > > defeats the special casing that the old interface relies on.
> > > > > > >=20
> > > > > > > Change nfsd_nl_threads_set_doit() to pass down the array from=
 userland
> > > > > > > as-is.
> > > > > > >=20
> > > > > > > Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread =
counts via netlink")
> > > > > > > Reported-by: Mike Snitzer <snitzer@kernel.org>
> > > > > > > Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@ke=
rnel.org/
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > >  fs/nfsd/nfsctl.c | 5 ++---
> > > > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > > index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80=
350668e94c395058bc228b08e64 100644
> > > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > > @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struc=
t sk_buff *skb,
> > > > > > >   */
> > > > > > >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct gen=
l_info *info)
> > > > > > >  {
> > > > > > > -	int *nthreads, count =3D 0, nrpools, i, ret =3D -EOPNOTSUPP=
, rem;
> > > > > > > +	int *nthreads, nrpools =3D 0, i, ret =3D -EOPNOTSUPP, rem;
> > > > > > >  	struct net *net =3D genl_info_net(info);
> > > > > > >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > > > > >  	const struct nlattr *attr;
> > > > > > > @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct s=
k_buff *skb, struct genl_info *info)
> > > > > > >  	/* count number of SERVER_THREADS values */
> > > > > > >  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > > > > >  		if (nla_type(attr) =3D=3D NFSD_A_SERVER_THREADS)
> > > > > > > -			count++;
> > > > > > > +			nrpools++;
> > > > > > >  	}
> > > > > > >=20
> > > > > > >  	mutex_lock(&nfsd_mutex);
> > > > > > >=20
> > > > > > > -	nrpools =3D max(count, nfsd_nrpools(net));
> > > > > > >  	nthreads =3D kcalloc(nrpools, sizeof(int), GFP_KERNEL);
> > > > > > >  	if (!nthreads) {
> > > > > > >  		ret =3D -ENOMEM;
> > > > > >=20
> > > > > > I noticed that this didn't go in to the recent merge window.
> > > > > >=20
> > > > > > This patch fixes a rather nasty regression when you try to star=
t the
> > > > > > server on a NUMA-capable box.
> > > > >=20
> > > > > The NFSD netlink interface is not broadly used yet, is it?
> > > > >=20
> > > >=20
> > > > It is. RHEL10 shipped with it, for instance and it's been in Fedora=
 for
> > > > a while.
> > >=20
> > > RHEL 10 is shiny and new, and Fedora is bleeding edge. It's not likel=
y
> > > either of these are deployed in production environments yet. Just say=
in
> > > that in this case, the Bayesian filter leans towards waiting a full d=
ev
> > > cycle.
> >=20
> > We don't consider it acceptable to allow known defects to persist in ou=
r
> > products just because they are bleeding edge.
>=20
> I'm not letting this issue persist. Proper testing takes time.
>=20
> The patch description and discussion around this change did not include
> any information about its pervasiveness and only a little about its
> severity. I used my best judgement and followed my usual rules, which
> are:
>=20
> 1. Crashers, data corrupters, and security bugs with public bug reports
>    and confirmed fix effectiveness go in as quickly as we can test.
>    Note well that we have to balance the risk of introducing regressions
>    in this case, since going in quickly means the fix lacks significant
>    test experience.
>=20
> 1a. Rashes and bug bites require application of topical hydrocortisone.
>=20
> 2. Patches sit in nfsd-testing for at least two weeks; better if they
>    are there for four. I have CI running daily on that branch, and
>    sometimes it takes a while for a problem to surface and be noticed.
>=20
> 3. Patches should sit in nfsd-next or nfsd-fixes for at least as long
>    as it takes for them to matriculate into linux-next and fs-next.
>=20
> 4. If the patch fixes an issue that was introduced in the most recent
>    merge window, it goes in -fixes .
>=20
> 5. If the patch fixes an issue that is already in released kernels
>    (and we are at rule 5 because the patch does not fix an immediate
>    issue) then it goes in -next .
>=20
> These evidence-oriented guidelines are in place to ensure that we don't
> panic and rush commits into the kernel without careful review and
> testing. There have been plenty of times when a fix that was pushed
> urgently was not complete or even made things worse. It's a long
> pipeline on purpose.
>=20
> The issues with this patch were:
>=20
> - It was posted very late in the dev cycle for v6.16. (Jeff's urgent
>   fixes always seem to happen during -rc7 ;-)
>=20
> - The Fixes: tag refers to a commit that was several releases ago, and
>   I am not aware of specific reports of anyone hitting a similar issue.
>=20
> - IME, the adoption of enterprise distributions is slow. RHEL 10 is
>   still only on its GA release. Therefore my estimation is that the
>   number of potentially impacted customers will be small for some time,
>   enough time for us to test Jeff's fix appropriately.
>=20
> - The issue did not appear to me to be severe, but maybe I didn't read
>   the patch description carefully enough.
>=20
> - Although I respect, admire, and greatly appreciate the effort Jeff
>   made to nail this one, that does not mean it is a pervasive problem.
>   Jeff is quite capable of applying his own work to the kernels he and
>   his employer care about.
>=20

The rules all make sense to me. In this case though, I felt the
potential harm from not taking this patch outweighed the risk. NUMA
hardware is more prevalent than you might think.=20

>=20
> > > > > Since this one came in late during the 6.16 dev cycle and the Fix=
es: tag
> > > > > references a commit that is already in released kernels, I put in=
 the
> > > > > "next merge window" pile. On it's own it doesn't look urgent to m=
e.
> > > > >=20
> > > >=20
> > > > I'd really like to see this go in soon and to stable. If you want m=
e to
> > > > respin the changelog, I can. It's not a crash, but it manifests as =
lost
> > > > RPCs that just hang. It took me quite a while to figure out what wa=
s
> > > > going on, and I'd prefer that we not put users through that.
> > >=20
> > > If someone can confirm that it is effective, I'll add it to nfsd-fixe=
s.
> >=20
> > I'm sure it is if Jeff spent time on it.
> >=20
> > We're going to try to get this into RHEL-10 ASAP, because dropped RPCs
> > manifest as datacenter-wide problems that are very hard to diagnose.
>=20
> It sounds like Red Hat also does not have clear evidence that links this
> patch to a specific failure experienced by your customers. This affirms
> my understanding that this fix is defensive rather than urgent.
>=20
> As a rule, defensive fixes go in during merge windows.
>=20
>=20
> > Its a
> > real pain that we won't have an upstream commit assigned for it.
>=20
> It's not reasonable for any upstream maintainer not employed by Red Hat
> to know about or cleave to Red Hat's internal processes. But, if an
> issue is on Red Hat's radar, then you are welcome to make its priority
> known to me so I can schedule fixes appropriately.
>=20
> All that said, I've promoted the fix to nfsd-fixes, since it's narrow
> and has several weeks of test experience now.
>=20

Many thanks!
--=20
Jeff Layton <jlayton@kernel.org>

