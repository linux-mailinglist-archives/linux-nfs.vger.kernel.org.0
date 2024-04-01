Return-Path: <linux-nfs+bounces-2585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9317A894461
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D421C21394
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5B4CE04;
	Mon,  1 Apr 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b="dzMlTCzL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562F481C6;
	Mon,  1 Apr 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992925; cv=none; b=WxnwWIKiSnQqWDj0ISNIeqoglnB3ZBPCzVa4onoqaLhG04PbdIAvCg1PZRrRnXXizTzeUV8+LSBalTIi/7BK2jsMUnufR9BudwZ/K+shG1ALXdhdZZkHsw5DebDkvQ4XaKrVrfLS628MFDG1KZzzJ059ClkD3i759bjSwS1t4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992925; c=relaxed/simple;
	bh=/gd/IDUDM2QAMzVDFtOTXs1+3awZOO9qC8xtxmt8JT4=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=bkzSINljY0CwRL+rhvjblSAUkluEEy/huLTZZ5cCSUoruAUkS0FJLsQ08l4MOi1JAmdGn2DQrQinKodyiiEUoJ+1gCk1Pf0kfMuise6PSapjBfjhwMZgmvc12mOomXdeAxf0sODYROTDrIFhjfhkVjI/ryUVmjZcDQKR8CXa8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=scpcom@gmx.de header.b=dzMlTCzL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711992900; x=1712597700; i=scpcom@gmx.de;
	bh=BRM8MxPwi3d472uvoCEaL5F5lAKEmhzYRMik63wqMOs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=dzMlTCzLTT0ANeL1LRK0AVcjw2p5TlJLSNJvGwP7aBaf5uzJr9y5jCjDtXsB7NTB
	 HIcgApvedObbm8j8Zq+sNAl6GG/anB41bFuEQCcPzwH0i/RMUEKadFUCL7hRVHMWZ
	 qXhzRBjxu35C+SJIVj3CmgtQTPCXyZTusz7GkBYM9yyok3nP91CkPLuwxqneVmYA0
	 gdzrD+Jrnq9/eUHufzLJVd19ymAK8fY8MKeG7TcYm2FWM+acp5/nNolvcnvzo4DPs
	 9SFEfJeQZitwq3voTEtqFv2MZK05QPsjntVywwDrzqZKlyilyY9E65WpTg4CilE/l
	 gEm5GmTe9S5q7vA6bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.10.6] ([10.236.10.6]) by msvc-mesg-gmx024 (via HTTP);
 Mon, 1 Apr 2024 19:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-00b2c0aa-3284-4d74-8184-71b5374bd8d7-1711992900521@msvc-mesg-gmx021>
From: Jan Schunk <scpcom@gmx.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, Jeff Layton
 <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David
 Howells <dhowells@redhat.com>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Aw: Re: [External] : nfsd: memory leak when client does many file
 operations
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Mon, 1 Apr 2024 19:35:00 +0200
In-Reply-To: <308BAEFD-8CAE-4496-8146-8C05DD78FB37@oracle.com>
References: <567BBF54-D104-432C-99C0-1A7EE7939090@oracle.com>
 <trinity-66047013-4d84-4eef-b5d3-d710fe6be805-1711316386382@msvc-mesg-gmx005>
 <6F16BCCE-3000-4BCB-A3B4-95B4767E3577@oracle.com>
 <trinity-ad0037c0-1060-4541-a8ca-15f826a5b5a2-1711396545958@msvc-mesg-gmx024>
 <088D9CC3-C5B0-4646-A85D-B3B9ACE8C532@oracle.com>
 <trinity-77720d9d-4d5b-48c6-8b1f-0b7205ea3c2b-1711398394712@msvc-mesg-gmx021>
 <51CAACAB-B6CC-4139-A350-25CF067364D3@oracle.com>
 <trinity-db344068-bb4b-4d0b-9772-ff701a2c70dd-1711663407957@msvc-mesg-gmx026>
 <C14AC427-BD99-4A87-A311-F6FB87FFC134@oracle.com>
 <trinity-157de7e0-d394-47fa-bb44-2621045a5b6e-1711812369391@msvc-mesg-gmx004>
 <Zgg9OzeFZUTc4hck@tissot.1015granger.net>
 <308BAEFD-8CAE-4496-8146-8C05DD78FB37@oracle.com>
X-Priority: 3
X-Provags-ID: V03:K1:8Qgcbc8YOU6Quga0KAVBADM5hF+gS5qYQPqH/liqGeWndvoiMC+1r5eXGQrvfunnNiLhQ
 +3n42PaHD2+YPfQLXLD4zIkU7TPZCDnCdyG3n1swmuxB72gSacaKUpyfU2p1pziYhPiTZ8mxVn2v
 5xlli/GWlifkrZ5/oWQ+GdyXJDMZRgV83QRiXmQk5wQAFDXqva3LsPVNGdmm+YYKV+NlZbBNR+dl
 z6amjIhyk0pFPnhNCP50PB13/HccFmalhcSWW0ZWb7Wncy1vcWv+FSfD4WhzzEZdwxkdrv9X+t54
 uc=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3toanD41SXU=;+9v1Zos/3j5NP5dHyFvayW1QJ+k
 sHMpCIi/6Tb/yiz8eI+1Vj6jzTi2vM8YKQ9bSyuBI2sWsF8Xb9TnBYc4CsAKxS5Q4rG2AMkSh
 faPWC5fleA+aVMcGAXtBjcAIRs/VbE7KsFXCkYdzlHA5d+IWamnrb0zTNNHE50n3RepAEAULY
 wZ6+WKjS/f2Pw/X9E4VaGkcCTYCylr0K1d80cHu8l1QCWxYFiRCUx3JMju7gqx8XnvfwinLko
 Zy2Ia96WsGIniIiyLCgEMAoEF6RZ0Amrbha2I8BuxRvbk4dU5z7kHpvy5xl5gPBH5P8DB1S19
 yDigwj+Sn/c4zYWZPY54yvYXlzbqUnnS/ed+zxO18rduSpCUansEsaFdqHI7n4jtJo9qtaMAF
 HePyQkSTsr5NMb7a3a/Beop5B7hv2VerWqUxd4WyVkEPEXK0NhqItGt8ruGA7Ngd9PZtVh+Wg
 qsHVfdkFznB/OUbLjfmToJehylAYb4hHvsj9/xnMKDGAf0lF4+lnKEx0ezY4TWuprG5VeGq9l
 bVZDlASo/8p4D4Rlz3/n+fl7Gr54sjNBt5fYsaBjlm97e8TIH+R8PVE7oBYJ4hzN4unYEn6EZ
 9RwDnFhPMfbzi1MriLheLHE8nQvaaQ80jZA0WJaX5zWEg2uo4h+E22lA/RBnLrqouDcVXNjpf
 zsTMNfEQAAyipcVnme5TZU0dMaE69SNpx77zgzn4SiWYSnhG75A3WwZBQwO/rZg=

Hi,
the bug report is now here:
https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D218671

PS: I can also confirm, if you use the latest v6=2E6=2E22 and only revert =
e18e157bb5c8 nfsd works without any issue=2E

> Gesendet: Montag, den 01=2E04=2E2024 um 16:08 Uhr
> Von: "Chuck Lever III" <chuck=2Elever@oracle=2Ecom>
> An: "Jan Schunk" <scpcom@gmx=2Ede>
> Cc: "Benjamin Coddington" <bcodding@redhat=2Ecom>, "Jeff Layton" <jlayto=
n@kernel=2Eorg>, "Neil Brown" <neilb@suse=2Ede>, "Olga Kornievskaia" <kolga=
@netapp=2Ecom>, "Dai Ngo" <dai=2Engo@oracle=2Ecom>, "Tom Talpey" <tom@talpe=
y=2Ecom>, "Linux NFS Mailing List" <linux-nfs@vger=2Ekernel=2Eorg>, "linux-=
kernel@vger=2Ekernel=2Eorg" <linux-kernel@vger=2Ekernel=2Eorg>, "David Howe=
lls" <dhowells@redhat=2Ecom>, "Linux regressions mailing list" <regressions=
@lists=2Elinux=2Edev>
> Betreff: Re: [External] : nfsd: memory leak when client does many file o=
perations
>=20
>=20
>=20
> > On Mar 30, 2024, at 12:26=E2=80=AFPM, Chuck Lever <chuck=2Elever@oracl=
e=2Ecom> wrote:
> >=20
> > On Sat, Mar 30, 2024 at 04:26:09PM +0100, Jan Schunk wrote:
> >> Full test result:
> >>=20
> >> $ git bisect start v6=2E6 v6=2E5
> >> Bisecting: 7882 revisions left to test after this (roughly 13 steps)
> >> [a1c19328a160c80251868dbd80066dce23d07995] Merge tag 'soc-arm-6=2E6' =
of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/soc/soc
> >> --
> >> $ git bisect good
> >> Bisecting: 3935 revisions left to test after this (roughly 12 steps)
> >> [e4f1b8202fb59c56a3de7642d50326923670513f] Merge tag 'for_linus' of g=
it://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mst/vhost
> >> --
> >> $ git bisect bad
> >> Bisecting: 2014 revisions left to test after this (roughly 11 steps)
> >> [e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9] Merge tag 'riscv-for-linus=
-6=2E6-mw1' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/riscv/linu=
x
> >> --
> >> $ git bisect bad
> >> Bisecting: 975 revisions left to test after this (roughly 10 steps)
> >> [4a3b1007eeb26b2bb7ae4d734cc8577463325165] Merge tag 'pinctrl-v6=2E6-=
1' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/linusw/linux-pinctr=
l
> >> --
> >> $ git bisect good
> >> Bisecting: 476 revisions left to test after this (roughly 9 steps)
> >> [4debf77169ee459c46ec70e13dc503bc25efd7d2] Merge tag 'for-linus-iommu=
fd' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jgg/iommufd
> >> --
> >> $ git bisect good
> >> Bisecting: 237 revisions left to test after this (roughly 8 steps)
> >> [e7e9423db459423d3dcb367217553ad9ededadc9] Merge tag 'v6=2E6-vfs=2Esu=
per=2Efixes=2E2' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/vfs/v=
fs
> >> --
> >> $ git bisect good
> >> Bisecting: 141 revisions left to test after this (roughly 7 steps)
> >> [8ae5d298ef2005da5454fc1680f983e85d3e1622] Merge tag '6=2E6-rc-ksmbd-=
fixes-part1' of git://git=2Esamba=2Eorg/ksmbd
> >> --
> >> $ git bisect good
> >> Bisecting: 61 revisions left to test after this (roughly 6 steps)
> >> [99d99825fc075fd24b60cc9cf0fb1e20b9c16b0f] Merge tag 'nfs-for-6=2E6-1=
' of git://git=2Elinux-nfs=2Eorg/projects/anna/linux-nfs
> >> --
> >> $ git bisect bad
> >> Bisecting: 39 revisions left to test after this (roughly 5 steps)
> >> [7b719e2bf342a59e88b2b6215b98ca4cf824bc58] SUNRPC: change svc_recv() =
to return void=2E
> >> --
> >> $ git bisect bad
> >> Bisecting: 19 revisions left to test after this (roughly 4 steps)
> >> [e7421ce71437ec8e4d69cc6bdf35b6853adc5050] NFSD: Rename struct svc_ca=
cherep
> >> --
> >> $ git bisect good
> >> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> >> [baabf59c24145612e4a975f459a5024389f13f5d] SUNRPC: Convert svc_udp_se=
ndto() to use the per-socket bio_vec array
> >> --
> >> $ git bisect bad
> >> Bisecting: 4 revisions left to test after this (roughly 2 steps)
> >> [be2be5f7f4436442d8f6bffbb97a6f438df2896b] lockd: nlm_blocked list ra=
ce fixes
> >> --
> >> $ git bisect good
> >> Bisecting: 2 revisions left to test after this (roughly 1 step)
> >> [d424797032c6e24b44037e6c7a2d32fd958300f0] nfsd: inherit required uns=
et default acls from effective set
> >> --
> >> $ git bisect good
> >> Bisecting: 0 revisions left to test after this (roughly 1 step)
> >> [e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4] SUNRPC: Send RPC message o=
n TCP with a single sock_sendmsg() call
> >> --
> >> $ git bisect bad
> >> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> >> [2eb2b93581813b74c7174961126f6ec38eadb5a7] SUNRPC: Convert svc_tcp_se=
ndmsg to use bio_vecs directly
> >> --
> >> $ git bisect good
> >> e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4 is the first bad commit
> >> commit e18e157bb5c8c1cd8a9ba25acfdcf4f3035836f4
> >=20
> > This is a plausible bisect result for this behavior, so nice work=2E
> >=20
> > David (cc'd), can you have a brief look at this? What did we miss?
> > I'm guessing it's a page reference count issue that might occur
> > only when the XDR head and tail buffers are in the same page=2E Or
> > it might occur if two entries in the XDR page array point to the
> > same page=2E=2E=2E?
> >=20
> > /me stabs in the darkness
> >=20
> >=20
> >> I found the memory loss inside /proc/meminfo only on MemAvailable
> >> MemTotal:         346948 kB
> >> On a bad test run in looks like this:
> >> -MemAvailable:     210820 kB
> >> +MemAvailable:      26608 kB
> >> On a good test run it looks like this:
> >> -MemAvailable:     215872 kB
> >> +MemAvailable:     221128 kB
>=20
> Jan, may I ask one more favor? Since this might take a little
> time to run down, can you open a bug report on
> bugzilla=2Ekernel=2Eorg <http://bugzilla=2Ekernel=2Eorg/>, and copy in t=
he symptomology and the
> bisect results? It will get assigned to Trond, and he can
> pass it to me=2E
>=20
> The problem looks like how we're using a page_frag_cache to
> handle the record marker buffers, but I'm not sure what the
> proper solution is yet=2E
>=20
> #regzbot ^introduced: e18e157bb5c8
>=20
> --
> Chuck Lever
>=20
>

