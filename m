Return-Path: <linux-nfs+bounces-20577-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMA+GldRzGmvSQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20577-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:57:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D956A3728A3
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 00:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B2B30614E8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36E466B66;
	Tue, 31 Mar 2026 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtYaM/o7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B33A9DA4
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997842; cv=pass; b=XREcL+DlHmZFq0pSFN8d/Qrjdd2v5DoAdYfhP640F7Y89nCTwyPvn1D4PWKpj+G3HFJZyVPuO7QwxH7h43ou6gn2jNFmOPXeKD+vgyjcLyY37DULqXcqJ9d+0uVXoiDsQgJlDssuI9XTQiz9ilOzgU+fsNnrnyvsfzUrRuTKPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997842; c=relaxed/simple;
	bh=a5+d0Vp/pzf2fLDvcOmDOqk65l0xEKwg9OAr843wcgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7OSuAGmhvh6I5DSbF5wsFYeGHzFnHA0KMDMtwQ9DCEPbjWO+eattALlL0DmFnNJewd2bKqNQK+AqMYMlJWk1gAhlUhmx2Pvh4IWyDMinTCFyc0viYgSAFPH055EesXSOMuY0sPFAbcdIy4+DAlPVdHS/qQXMU2Hhu4kmn00GM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtYaM/o7; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66beb35caafso4923390a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 15:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774997838; cv=none;
        d=google.com; s=arc-20240605;
        b=J3djq8UVWJazHJiFpo9ww9zs8/u832wr+Xil+RhhnAytB0/ReT9i8JM86DUIteO56q
         ytFUUGG9XXBhgVfPkv+RaaB5GRNMLTHn0jhqSY/v8Y2GMVVEiQPyctG8danIGvfE6+Jz
         QdVKVDdoW+10kH1Tceu58IdtrwUfE83OslpgkfFTAkfUVEhOvJqX64h9X18e9C8kdAOG
         eDc+yW98xBW8WSiLjhEKHViP9Ecw5ynCf2kY01A3SZOf7cKr9im2+6cHC4f3uNR+DW7f
         aVCW/+GObaZRaHyavZopLnBjCq43soHT1flyBrbzRrOmRR43eHrBW53811oWVDqNtm2t
         tmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ibc6Ewfbl8pnCa8XW9tabf/9S6LjBanYYcMFfIdMQuI=;
        fh=EAqrcMy07MR3yTi9CZsiFsHZXK/d39WYHDflTUlGkqo=;
        b=lafgkoaQ4aD1uQ/Tb2+Zh8ExUAQXID5TRCP4XukbfW8HV7prLxb7q703C5m+/bOcjM
         kGr8U8dqqm9BmIgVFa7VoTd+HRx/UrkKJEarUCIq+rNrT1rn4rqNW5i8fbhGas7ID2L0
         wmVWtJPukdIFl/yAYF2xdnGw+Bj9haHvVO0ClsJOitJWsmcvmhutm1EedD835cm98iwE
         5fCjV8KTdKrd3cGu/JYRcWnbg0p0zjdglXTnEBR+jpZ7jIi2o0fW9Og11AXhsI5D64ej
         Vf1k8iC+bxp8pDZ0n7oJDl26MHMBwFXfUVbhMzX7WU6jIE9meVfdCWxedU34WDWUEZdP
         wd4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774997838; x=1775602638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibc6Ewfbl8pnCa8XW9tabf/9S6LjBanYYcMFfIdMQuI=;
        b=TtYaM/o7OxUZiyw7SCJZn0yPe8rK1nimMwHSqJPGWlgKCMHDyATa1s6S+BDto8wXCh
         iRVWcfLRsS1uJfCsqiKr3oOwNzOrtTexrjKvUPVfZjgqUlALtTLgcaxiBjACPc+Jg3Va
         gARxJoE+uhRiNNZP6pNf66/Pvm5hw/LrAQ2cQfK+wJ8Nm8KaOdD5ShBX8tb7bq6RyfeU
         iBgvom/iI/lQtc1wAfU1lsM/lw1c0Ash9yuMj0UcvulszbV0/C7IYYINjO9Pw8pdZarp
         PDIMGvreoyQTgdyyliFXY3jokbNYGxvQK7+g1jk+KPESAsBk0DXBy7eHT3u9lkPpjlDI
         KpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997838; x=1775602638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ibc6Ewfbl8pnCa8XW9tabf/9S6LjBanYYcMFfIdMQuI=;
        b=O0L5wwfaCMcpYi/+1QrxvNs5p2aGbbggXtxYTUJswgYfbA/ljoaQ180LapgEwoqa0p
         jBnbGG5dKedIpqPh8UV31zr5HQXLBf2kPl5D/aAi4LaZnbTBY5W4USrsd2F3LGjVIa7k
         /GGIPuqs3yErQNZkMED9UBD4GwY0EeLZcbrg/IhFfVV5DMeGcon4P3bY2WoxS5f17c1K
         PqczDjgE5ENfuKB1Et8ktKDloKARhSbtO3QSsWJ7glIJ+79oRD3svKKY1OzWEFazIhQk
         snYGfc/UbMzS7rfYCGeODM8fh0lg2FG0yFTiorQjmrpSZps+tKbXD3SV/qXCvJk+LU3P
         XwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVZCPro35l2d3klZ0rOT9dtjMSzj5SBkuGv8fejbgt4djLjl5auhpZLp4Cp4/CO7Qkt3/2/g6CIZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0klqz3h6DMZ1NmrKW5DlQ9iaVKoZ77iN9xIVv/65stTI6rQSM
	6/Kw2BFR4sfkCdAByGHiyeYH6oOeYrKyWwsGC68eUXfy2lYvsPkASylHgtgsZ3wIMl6V1BkP95g
	Sewdc2D9nB2pkWRqx8Ho0gaB93zYn7Q==
X-Gm-Gg: ATEYQzwCymjSIvzHB0w3gOrrhWpy7lidSBXRSIHVh9/qddKr2+gPaxLhUjoDA3UDQcJ
	TBpiUXJQJyq4IdL5ex2+3RAR5TrGexT7PEw1Is16P5TxN/jdtA/40zWQf8Z6jOk34dKbTUZEn0R
	kxSzbJNIV1N1TaU4JQlaVYfcfLYmJkgqFW9UgVIqjsHy+gdLwqi56Zm7oLumrkPSpO7qZDQab15
	l9qWEK00Rae9QdLMXmpeYfyMG4SEneJ0QmdhX3Qh5zobWdwYhx0KBPhR6HCg8GkMGjyNh7BdUvd
	TGUhSR/PC4CvVR9g2tSOgC2IW1LZw39oqQlI
X-Received: by 2002:a05:6402:13c9:b0:66a:72e5:6af5 with SMTP id
 4fb4d7f45d1cf-66db09e2695mr808873a12.17.1774997837505; Tue, 31 Mar 2026
 15:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
 <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org> <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
 <284ca17e74af8c4f5942b2952f2bf75490dd17c0.camel@kernel.org>
 <CAN-5tyFsEUcSUycb4JjxH5v754SefwOH=zt24KtxEC_Ow4OjMw@mail.gmail.com>
 <80b423c66dba84b46be1084307d2c66b935065bc.camel@kernel.org>
 <acbJsryTMYCMlE_o@mana> <CAN-5tyFQrt7WyW4=qLodKS2-eckAetKjs15A6U1OOdGPSL58XQ@mail.gmail.com>
 <acbfV0C-fAy4nZ-i@mana> <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
In-Reply-To: <CAN-5tyGd1ZtL-sKvT251=BZa-38nOAEYbiZq5Bk+XN_ETX0PWA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 31 Mar 2026 15:57:05 -0700
X-Gm-Features: AQROBzBkQvXDrUMBHxKSO-aHKx5LhA612Gnctl6MJ5Y8T3RiT9WrODEoIqxWNW0
Message-ID: <CAM5tNy6bbauaD=qskHDHN89p_0CcUHBMY7dh7Ve=AV80dM45gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Thomas Haynes <loghyr@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20577-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rickmacklem@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: D956A3728A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:18=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu>=
 wrote:
>
> On Fri, Mar 27, 2026 at 4:02=E2=80=AFPM Thomas Haynes <loghyr@gmail.com> =
wrote:
> >
> > On Fri, Mar 27, 2026 at 03:36:12PM -0800, Olga Kornievskaia wrote:
> > > On Fri, Mar 27, 2026 at 2:22=E2=80=AFPM Thomas Haynes <loghyr@gmail.c=
om> wrote:
> > > >
> > > > On Fri, Mar 27, 2026 at 12:59:54PM -0800, Jeff Layton wrote:
> > > > > On Fri, 2026-03-27 at 12:20 -0400, Olga Kornievskaia wrote:
> > > > > > On Fri, Mar 27, 2026 at 11:50=E2=80=AFAM Jeff Layton <jlayton@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, 2026-03-27 at 11:11 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayto=
n@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > xfstest generic/728 fails with delegated timestamps. The =
client does a
> > > > > > > > > removexattr and then a stat to test the ctime, which does=
n't change. The
> > > > > > > > > stat() doesn't trigger a GETATTR because of the delegated=
 timestamps, so
> > > > > > > > > it relies on the cached ctime, which is wrong.
> > > > > > > > >
> > > > > > > > > The setxattr compound has a trailing GETATTR, which ensur=
es that its
> > > > > > > > > ctime gets updated. Follow the same strategy with removex=
attr.
> > > > > > > >
> > > > > > > > This approach relies on the fact that the server the serves=
 delegated
> > > > > > > > attributes would update change_attr on operations which mig=
ht now
> > > > > > > > necessarily happen (ie, linux server does not update change=
_attribute
> > > > > > > > on writes or clone). I propose an alternative fix for the f=
ailing
> > > > > > > > generic/728.
> > > > > > > >
> > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > index 7b3ca68fb4bb..ede1835a45b3 100644
> > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > @@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(s=
truct inode
> > > > > > > > *inode, const char *name)
> > > > > > > >             &res.seq_res, 1);
> > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > >         if (!ret)
> > > > > > > > -               nfs4_update_changeattr(inode, &res.cinfo, t=
imestamp, 0);
> > > > > > > > +               if (nfs_have_delegated_attributes(inode)) {
> > > > > > > > +                       nfs_update_delegated_mtime(inode);
> > > > > > > > +                       spin_lock(&inode->i_lock);
> > > > > > > > +                       nfs_set_cache_invalid(inode, NFS_IN=
O_INVALID_BLOCKS);
> > > > > > > > +                       spin_unlock(&inode->i_lock);
> > > > > > > > +               } else
> > > > > > > > +                       nfs4_update_changeattr(inode, &res.=
cinfo, timestamp, 0);
> > > > > > > >
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > >
> > > > > > > What's the advantage of doing it this way?
> > > > > > >
> > > > > > > You just sent a REMOVEXATTR operation to the server that will=
 change
> > > > > > > the mtime there. The server has the most up-to-date version o=
f the
> > > > > > > mtime and ctime at that point.
> > > > > >
> > > > > > In presence of delegated attributes, Is the server required to =
update
> > > > > > its mtime/ctime on an operation? As I mentioned, the linux serv=
er does
> > > > > > not update its ctime/mtime for WRITE, CLONE, COPY.
> > > > > >
> > > > > > Is possible that
> > > > > > some implementations might be different and also do not update =
the
> > > > > > ctime/mtime on REMOVEXATTR?
> > > > > >
> > > > > > Therefore I was suggesting that the patch
> > > > > > relies on the fact that it would receive an updated value. Of c=
ourse
> > > > > > perhaps all implementations are done the same as the linux serv=
er and
> > > > > > my point is moot. I didn't see anything in the spec that clarif=
ies
> > > > > > what the server supposed to do (and client rely on).
> > > > > >
> > > > >
> > > > > (cc'ing Tom)
> > > > >
> > > > > That is a very good point.
> > > > >
> > > > > My interpretation was that delegated timestamps generally covered
> > > > > writes, but SETATTR style operations that do anything beyond only
> > > > > changing the mtime can't be cached.
> > > > >
> > > > > We probably need some delstid spec clarification: for what operat=
ions
> > > > > is the server required to disable timestamp updates when a write
> > > > > delegation is outstanding?
> > > > >
> > > > > In the case of nfsd, we disable timestamp updates for WRITE/COPY/=
CLONE
> > > > > but not SETATTR/SETXATTR/REMOVEXATTR.
> > > > >
> > > > > How does the Hammerspace anvil behave? Does it disable c/mtime up=
dates
> > > > > for writes when there is an outstanding timestamp delegation like=
 we're
> > > > > doing in nfsd? If so, does it do the same for
> > > > > SETATTR/SETXATTR/REMOVEXATTR operations as well?
> > > >
> > > > Jeff,
> > > >
> > > > I think the right way to look at this is closer to how size is
> > > > handled under delegation in RFC8881, rather than as a per-op rule.
> > > >
> > > > In our implementation, because we are acting as an MDS and data I/O
> > > > goes to DSes, we already treat size as effectively delegated when
> > > > a write layout is outstanding. The MDS does not maintain authoritat=
ive
> > > > size locally in that case. We may refresh size/timestamps internall=
y
> > > > (e.g., on GETATTR by querying DSes), but we don=E2=80=99t treat tha=
t as
> > > > overriding the delegated authority.
> > > >
> > > > For timestamps, our behavior is effectively the same model. When
> > > > the client holds the relevant delegation, the server does not
> > > > consider itself authoritative for ctime/mtime. If current values
> > > > are needed, we can obtain them from the client (e.g., via CB_GETATT=
R),
> > > > and the client must present the delegation stateid to demonstrate
> > > > that authority. So the authority follows the delegation, not the
> > > > specific operation.
> > >
> > > What happens when the client holding the attribute delegation (it's
> > > the authority) is doing the query? Is it the server's responsibility
> > > to query the client before replying.
> >
> > The Hammerspace server on a getattr checks to see if there is
> > a delegated stateid (and whether it is the client making the request
> > or not). If it is and the GETATTR asks for FATTR4_SIZE, FATTR4_TIME_MOD=
IFY,
> > or FATTR4_TIME_METADATA, then it will send a CB_GETATTR before
> > responding to the client.
I thought the requirement to do a CB_GETATTR was if the GETATTR is
from a different client than the one holding the delegation, at least for
NFSv4.1/4.2? (Basically, if a 4.1/4.2 client holds a write delegation, it
is expected to "fake" the attributes and also reply with those faked attrib=
utes
to the server in a CB_GETATTR reply, so that other clients see the "faked"
attributes. Only after a DELEGRETURN does the server have the definitive
values for these attributes. At least that's the way I understood it?)

(Admittedly, for NFSv4.0, knowing of the client doing the GETATTR was
 the same one as the client holding the delegation wasn't often the case,
 but I basically ignore NFSv4.0 now. Imho NFSv4.0 delegations were
 so messy they weren't worth implementing.)

rick
>
> So... while I might not be running the latest Hammerspace bits and
> something has changed but I do not see Hammerspace server sending a
> CB_GETATTR when the "client is making a getattr request with a
> delegated stateid". Example is the CLONE operation with an accompanied
> GETATTR. The server in this case updates the change attribute and
> mtime and returns different from what the client had previously in the
> OPEN back to the client (this is what the test expect but I think
> that's contradictory to what is said above). (To contrast nfsd server
> does not update the change attribute or mtime and returns the same
> value and thus making xfstest fail). So if the spec mandates that
> before answering the GETATTR a CB_GETATTR needs to be sent then
> neither of the server (Hammerspace nor linux) do that. But then again
> I'm not sure the client is not at fault for sending a GETATTR in the
> CLONE compound in the first place. For instance client does not have a
> GETATTR in the COPY compound (and then fails to pass xfstest that
> checks for modifies ctime/mtime). But the solution isn't clear to is
> it like Jeff's REMOVEXATTR approach to add the GETATTR to the COPY
> compound but that then should trigger a CB_GETATTR back to the client.
> Again probably none of the servers do that...
>
> Another point I would like to raise is: doesn't it seem
> counter-intuitive to be in a situation where we have a
> delegation-holding client sending a GETATTR and then a server needing
> to do a CB_GETTATTR to the said client to fulfill the request.
> Delegations were supposed to reduce traffic and now we are introducing
> additional traffic instead. I guess I'm arguing that the client is
> broken to ever query for change_attr, mtime if it's holding the
> delegation. Yet the linux client (I could be wrong here) is written
> such that change_attr or mtime has to always come from the server. Say
> the application did a write() followed by a stat(). Client can't
> satisfy stat() without reaching out to the server. Yet the server is
> not the authority and before it can generate the reply for
> change_attr, mtime, it needs to callback to the client (CB_GETATTR).
> It seems it would have been better to never get a delegated attribute
> delegation in the first place?
>
> > While it does not do so, if the client sent in a SETATTR in the
> > same compound we could short circuit that. Think a sort of WCC.
> >
> > > Example, client sends a CLONE
> > > operation which has a GETATTR attached. (1) is the server supposed to
> > > issue a CB_GETATTR before replying to the compound? (2) is the client
> > > not supposed to send any GETATTRs while holding an attribute
> > > delegation? CLONE is a modifying operation but client hasn't done any
> > > actual modifications to the opened file so a CB_GETATTR would return
> > > that file hasn't been modified. Is the server then not going to
> > > express that the file has indeed been modified when replying to
> > > GETATTR?
> >
> > The server could argue that the client wants to know what it thinks.
> > But that isn't the argeement. The server has to query those values
> > before sending them on.
> >
> > >
> > > > That said, I don=E2=80=99t think we=E2=80=99ve fully resolved the s=
emantics for all
> > > > metadata-style ops either. WRITE and SETATTR are clear in our model=
,
> > > > but for things like CLONE/COPY/SETXATTR/REMOVEXATTR, we=E2=80=99ve =
likely
> > > > been relying on assumptions rather than a fully consistent rule.
> > > > I.e., CLONE and COPY we just pass through to the DS and we don't
> > > > implement SETXATTR/REMOVEXATTR.
> > > >
> > > > So the spec question, as I see it, is not whether REMOVEXATTR (or
> > > > any particular op) should update ctime/mtime, but whether delegated
> > > > timestamps are meant to follow the same attribute-authority model
> > > > as delegated size in RFC8881. If so, then we expect that the server
> > > > should query the client via CB_GETATTR to return updated ctime/mtim=
e
> > > > after such operations while the delegation is outstanding.
> > > >
> > > > Thanks,
> > > > Tom
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > > It's certainly possible that the REMOVEXATTR is the only chan=
ge that
> > > > > > > occurred. With what I'm proposing, we don't even need to do a=
 SETATTR
> > > > > > > at all if nothing else changed. With your version, you would.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handli=
ng for extended attributes")
> > > > > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
> > > > > > > > >  fs/nfs/nfs42xdr.c       | 10 ++++++++--
> > > > > > > > >  include/linux/nfs_xdr.h |  3 +++
> > > > > > > > >  3 files changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > > > > > index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172f=
c11c9d5a55b3621977ac83bb98f7c20 100644
> > > > > > > > > --- a/fs/nfs/nfs42proc.c
> > > > > > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > > > > > @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file =
*src_f, struct file *dst_f,
> > > > > > > > >  static int _nfs42_proc_removexattr(struct inode *inode, =
const char *name)
> > > > > > > > >  {
> > > > > > > > >         struct nfs_server *server =3D NFS_SERVER(inode);
> > > > > > > > > +       __u32 bitmask[NFS_BITMASK_SZ];
> > > > > > > > >         struct nfs42_removexattrargs args =3D {
> > > > > > > > >                 .fh =3D NFS_FH(inode),
> > > > > > > > > +               .bitmask =3D bitmask,
> > > > > > > > >                 .xattr_name =3D name,
> > > > > > > > >         };
> > > > > > > > > -       struct nfs42_removexattrres res;
> > > > > > > > > +       struct nfs42_removexattrres res =3D {
> > > > > > > > > +               .server =3D server,
> > > > > > > > > +       };
> > > > > > > > >         struct rpc_message msg =3D {
> > > > > > > > >                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_C=
LNT_REMOVEXATTR],
> > > > > > > > >                 .rpc_argp =3D &args,
> > > > > > > > > @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexatt=
r(struct inode *inode, const char *name)
> > > > > > > > >         int ret;
> > > > > > > > >         unsigned long timestamp =3D jiffies;
> > > > > > > > >
> > > > > > > > > +       res.fattr =3D nfs_alloc_fattr();
> > > > > > > > > +       if (!res.fattr)
> > > > > > > > > +               return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +       nfs4_bitmask_set(bitmask, server->cache_consisten=
cy_bitmask,
> > > > > > > > > +                        inode, NFS_INO_INVALID_CHANGE);
> > > > > > > > > +
> > > > > > > > >         ret =3D nfs4_call_sync(server->client, server, &m=
sg, &args.seq_args,
> > > > > > > > >             &res.seq_res, 1);
> > > > > > > > >         trace_nfs4_removexattr(inode, name, ret);
> > > > > > > > > -       if (!ret)
> > > > > > > > > +       if (!ret) {
> > > > > > > > >                 nfs4_update_changeattr(inode, &res.cinfo,=
 timestamp, 0);
> > > > > > > > > +               ret =3D nfs_post_op_update_inode(inode, r=
es.fattr);
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > > +       kfree(res.fattr);
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> > > > > > > > > index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f=
721cfe01bfc60f5981396958084d627 100644
> > > > > > > > > --- a/fs/nfs/nfs42xdr.c
> > > > > > > > > +++ b/fs/nfs/nfs42xdr.c
> > > > > > > > > @@ -263,11 +263,13 @@
> > > > > > > > >  #define NFS4_enc_removexattr_sz                (compound=
_encode_hdr_maxsz + \
> > > > > > > > >                                          encode_sequence_=
maxsz + \
> > > > > > > > >                                          encode_putfh_max=
sz + \
> > > > > > > > > -                                        encode_removexat=
tr_maxsz)
> > > > > > > > > +                                        encode_removexat=
tr_maxsz + \
> > > > > > > > > +                                        encode_getattr_m=
axsz)
> > > > > > > > >  #define NFS4_dec_removexattr_sz                (compound=
_decode_hdr_maxsz + \
> > > > > > > > >                                          decode_sequence_=
maxsz + \
> > > > > > > > >                                          decode_putfh_max=
sz + \
> > > > > > > > > -                                        decode_removexat=
tr_maxsz)
> > > > > > > > > +                                        decode_removexat=
tr_maxsz + \
> > > > > > > > > +                                        decode_getattr_m=
axsz)
> > > > > > > > >
> > > > > > > > >  /*
> > > > > > > > >   * These values specify the maximum amount of data that =
is not
> > > > > > > > > @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(=
struct rpc_rqst *req,
> > > > > > > > >         encode_sequence(xdr, &args->seq_args, &hdr);
> > > > > > > > >         encode_putfh(xdr, args->fh, &hdr);
> > > > > > > > >         encode_removexattr(xdr, args->xattr_name, &hdr);
> > > > > > > > > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > > > > > > > >         encode_nops(&hdr);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr=
(struct rpc_rqst *req,
> > > > > > > > >                 goto out;
> > > > > > > > >
> > > > > > > > >         status =3D decode_removexattr(xdr, &res->cinfo);
> > > > > > > > > +       if (status)
> > > > > > > > > +               goto out;
> > > > > > > > > +       status =3D decode_getfattr(xdr, res->fattr, res->=
server);
> > > > > > > > >  out:
> > > > > > > > >         return status;
> > > > > > > > >  }
> > > > > > > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_=
xdr.h
> > > > > > > > > index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b56=
85f46136a210c8e11c20a54d6ed9dad 100644
> > > > > > > > > --- a/include/linux/nfs_xdr.h
> > > > > > > > > +++ b/include/linux/nfs_xdr.h
> > > > > > > > > @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
> > > > > > > > >  struct nfs42_removexattrargs {
> > > > > > > > >         struct nfs4_sequence_args       seq_args;
> > > > > > > > >         struct nfs_fh                   *fh;
> > > > > > > > > +       const u32                       *bitmask;
> > > > > > > > >         const char                      *xattr_name;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  struct nfs42_removexattrres {
> > > > > > > > >         struct nfs4_sequence_res        seq_res;
> > > > > > > > >         struct nfs4_change_info         cinfo;
> > > > > > > > > +       struct nfs_fattr                *fattr;
> > > > > > > > > +       const struct nfs_server         *server;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  #endif /* CONFIG_NFS_V4_2 */
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.53.0
> > > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > >
> > > > > --
> > > > > Jeff Layton <jlayton@kernel.org>
> > > >
>

