Return-Path: <linux-nfs+bounces-20343-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLf4IdkSwmm9ZQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20343-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 05:28:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F21302045
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 05:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA0F3069631
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 04:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB7248883;
	Tue, 24 Mar 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYtuWiNL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B1241695
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326485; cv=pass; b=AGMDyVBzoitqzl/oGnYxp/L8vqe+UKJB8YUA33mmfJnhzOBX5VPkTdVToUaVrmUDDqzEVZzIrPMA5Qtj8HunGBCQU0vDrh8h4mUT5VHxijnxJ9dGjLZ9Kl+hjSDlg+HWsN4aG6B3ARjSVYvJMvkbP09F781htzSE+cjIIjec5nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326485; c=relaxed/simple;
	bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfzJhGJKbs5hoCtO002QKgwCdeEkLiymmlvQqA+m0T6fbXWa03glUR86KRvK7+fkXhCPAbgkjJCpd4U/anDR4YsJYlBUw/j8usEnh+MRuR4+FchpIweXynN9+3oXy9Nf/OjgHE1ptCARiYxmShzb7yJ8Ctt0BI/btCenmpqTXoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYtuWiNL; arc=pass smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-66a4c6bb6ecso82361a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 21:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326482; cv=none;
        d=google.com; s=arc-20240605;
        b=f5DZzQooZcIgGzskEfE1xWmhW2R8exvvZ5O+nj7QssCoXp+n1Tuvhy1hn2/eVaADbN
         +rImqQwHLLbxpU0JLkQ3nKtRF3+PCjq8OZmrUwM8F60p+SEyQ4Nb29hBhUIArPtt3086
         tHVkfVH9U9ws+hIINJF4A2fC1VWvQ3brDENaAGxv0tSK0XJv+29/V7vF+axEzmWt4WHe
         wq7x+uahoEEQUI+kidbX1zkX/Asj4CyIqEeuiGjPsH3yNqcJL41WGkvgFKPmimsVf51k
         NogqCXYNBautgaIel9KeBLZ3AlV0ayDLeIbzHXPYD1C5ESZkm9GwnppJP4DcwOiBPgYq
         2qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        fh=IzVGBJm2HNgjcYHOim5XW9E4inBpW71LLUdIKoZFm9M=;
        b=Y59qvQF5w0b90btsLIhVrV6QgUa7GhBnX5szsAKCcv9JRZJqLpy74p3Anpu5/+L45b
         aRSzRwrtotalrWDVG03YWCVVxvcTGAvEbasl2wEXAcAKiOZCtdRdmSbrbT5+1kavW4Aq
         IZtepuZvdRpnzCwZYGKNOFeFh1hTOk8zp4+oS7vKxN4I4B8ZKqmhWQMmz/p+DE6y7FrS
         W39Hes7fQqh2E0UHv82cHYJfg+y24vpWKs/VFXyS/xwC2wB13l7tdf4f72ay7Jj3DNb2
         L99BTOmt5yCOr3YK5u/1t3N4CBUWCWwV68tDupe8vve6ceuHeeiWRnjjfp2PnNbT5yQD
         FAcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326482; x=1774931282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=RYtuWiNLJx8R2b+1RiJZYf2azakQdqAi1ykYm0/hZWwIs0++0rHOLlrJKs1SRXw4Zc
         Qs7r4hxOykxbFtU39S+D6Az9RneGmw+ZOxuZmdUXftQkeZjWpkY9OCoR9ZEmgCZGwOzI
         +prX6Jpp+qhOBEgtlIOeA+aUMh+mrwwZ0bew5vf2Qskt5H6TuxsJm/BYkFbhlbv70XwO
         t58pflR/BffgkEgTylXgwE213zVR7ZuLyq417/WcCspXWVNLjmEIzjamC2lUuV0kWL5K
         XAz/XGdgil5SIxl2LAlX1GC4Fa4jCHk/S+ha8N0jSsepbSLuW6M4KQnSoDXhwXOgYAHg
         Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326482; x=1774931282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=ipnWJ9G0spY2LZNwvBXjWQGYxrpz9r3+0LY1pySjqIDRWBcWguABr0ryLETtj4qrSk
         0o9el55Bbb+IghbsogNLQ9IalzF6maaBm0m1f8aAN7S+0y6Ir9zEaviFLGxVJLx+2Wmz
         CjDeJdxvn6n++5sOy0XmLDkN1ZmGKJuPSrSVr5FWeSZnV92zWv1Y2YmrpiFP47v61sYm
         Cb4oY0R+63bscfa9GOwyGMaik0orVxm0jBVCI7qHpTOT7oy+p43x9UtQIwZMdYkdK56W
         U9ZrgWqPBbXjP1iUiTnm4KgMgWoQpIPp3lQtenDV6JGDJ8GnPOCZE6GHk6WQrXEC/12K
         GvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGlS/wYf1kEJZzm5WfOY+Tjp7HlDvGuB4B4pngB3edzUMAaWyCwfNh6C3Nq/NdSADWBzU/MqN6igA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOd+x9t6rftYnnsUHlZOySsQHapZyM1a1YYTLQvLUFfnw4ducM
	3732A1hmvwVwmlYqVYunCgsUsWMNKSqkloR/YZugQmTKfoVcoeJofu+zOXTJ7sktKpYna0Bj0Fs
	l7FIdkI7WeGmZyBzODssYGOzUSkUqxnQ=
X-Gm-Gg: ATEYQzx4xeSTkLlBspnF29D4CYOKVFZJXS0v9WZEZNDTBHvLkUBRjXWTJq1RCvpOeHN
	y8AKqRFG1f5rqjrd8N9r7F5VPvFNIDI8mza7IkBdE8nBXlDuicWws7hPhztul+Ss1aKPR7YfxR0
	q+v0jLfJtV9ae4WG1XrxitdGZKEt6VvUHOyyjpvXLxC4ckw107UTqrSYD2/cPy+ik3LAFzXQIzo
	3VBO9705OEUdhgJ0EAP+ce7CBvnD1Uu716t3jsMF6kEgKsLRH7zeWfiz/SA9cW0lTjS8EejpXsM
	0VsuPJdrIDAhVQ5mQbgIDITpWDWku2N2P0f2lpQ=
X-Received: by 2002:a05:6402:270a:b0:66a:3419:248a with SMTP id
 4fb4d7f45d1cf-66a34192961mr1158702a12.13.1774326482054; Mon, 23 Mar 2026
 21:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
 <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
In-Reply-To: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Tue, 24 Mar 2026 12:27:50 +0800
X-Gm-Features: AQROBzBgTmKHaA7x9bBR6YuiaU8Gh2HBa_zkliE59q0Q7S-SffyKp90n7TFmYBI
Message-ID: <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20343-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E1F21302045
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon and maintainers,

Just a gentle ping on this patch series.

Following up on my previous email regarding the testing methodology
(using virtme-ng, verifying the Oops fix in Patch 1, and confirming
the strictness of strsep + kstrtouint).

Does the provided testing information address the concerns? Please let
me know if there's anything else I should clarify, or if a v3 is
needed to move this forward.

Thanks,
Yufan

On Wed, Mar 4, 2026 at 11:28=E2=80=AFPM Eric_Terminal <ericterminal@gmail.c=
om> wrote:
>
> On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> > Hi,
> >
> > Thanks for your patches.
> >
> > I would like to understand what testing has been performed on these pat=
ches.
> >
> > With the possible exception of patch 3/4, I feel that unless they
> > are motivated as bug fixes, these changes are too complex to accept
> > without testing. Although the opinions of the relevant maintainers
> > may differ.
> >
> > And as for 3/4, I lean towards falling into the policy regarding
> > clean-ups not being generally accepted unless it is part of other work.
>
> Hi,
>
> Thanks for the feedback. I've verified the series using virtme-ng and
> a userspace mock harness (for the 9p tokenizing logic).
>
> Regarding Patch 1: This is primarily a stability fix. I've tested the
> error paths by forcing init failures on a non-Xen system; dmesg
> confirms the new sentinel-based cleanup (NULL-ing intf/data and
> checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
> during teardown.
>
> Regarding the "complexity" in Patch 2: The strsep + kstrtouint
> approach was chosen for strictness. I've verified it handles cases
> like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
> latter is now rejected with -EINVAL, whereas simple_strto* would have
> silently accepted partial values.
>
> The same applies to Patches 3 and 4. The migration to kstrto* ensures
> that sysfs/procfs interfaces now properly validate the entire input
> string.
>
> P.S. I used a translation tool for the message above, so please excuse
> any awkward wording.
>
> Thanks,

