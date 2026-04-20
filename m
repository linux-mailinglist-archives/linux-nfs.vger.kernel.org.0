Return-Path: <linux-nfs+bounces-20966-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCOWEN3T5WmmoQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20966-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 09:21:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9D427AB5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3344300372C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2026 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E202D738A;
	Mon, 20 Apr 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZi0S1Ay"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A6296BCF
	for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669654; cv=pass; b=NnY/rgspLiFBwDcTF9ygH5PA55F/E2b4nHCQHjiCoQelaxHjswRy6x3w8WcoL1NJW+PPW4Ncw6VbpA11B8lJPkZ7+u5hJeBXCZNyXJROQbpdM7Rk/rR0ISkpJimo5C0PItJQF7suzEET5ubWlL0U3CQdnYhBw+CwqQuX+cevjWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669654; c=relaxed/simple;
	bh=3PoSEU0MLplYolt2G+sl9yrRfXWDBd5tOwRXHg21c/Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q3N69fa71AuG2De3007uY5nl3crIWJySm8uGG6hC02dHTnLlEA30/wJj3fOXIWSWE6GUCu8b0cJIaN5r4NkHijp/3dg2amvbwXgo+wPiMqn4f7q/s/jOSr7dE8jTJhh17kUl7M6LGWt+nQ4nRRdn/uBEuWrNKqSR2WyLvSyytTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZi0S1Ay; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b936331786dso333396866b.3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2026 00:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776669651; cv=none;
        d=google.com; s=arc-20240605;
        b=jVANxjVq/SV1ZmdR8r9zWDULbH2Lu/CgtlyefLLk6iFEQJd9/2aaMK+H+8OArgeiwa
         00t+bO2L3aXhhfkDd/NDBu0t3vcAHbciPx6I3T3VMfUoMLMWwNPnm+p54abnemb1ldhg
         cn535erU2qLy0jKgQ+IFq/XXhbQRqIMwkQZGKhLR4mYf8mFQEDaqml40gYwoj9EqlCNC
         R7m2McVoGb8TLUfMQWcT++lkZkT3QQZ5U02EXiarAk1KF8j9faW96A2VzcJcp5NH3jMk
         X957GcewvUdJp3cSuxUpUokz2UdCa2mGZA+lN5LabZBzubZfYb1QmeKQc+qY52vfeuJr
         QXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3PoSEU0MLplYolt2G+sl9yrRfXWDBd5tOwRXHg21c/Y=;
        fh=A6VhHI7NKHnmfjjs9vgKiwsl8TnYIjA9XaJXQoRXXsA=;
        b=fp/T1ENVppnqJxThWTyI7buk8e5qdkGHPOcQ3s6EiWGEjZ5sh95l6bXyYMECFpJdHT
         IStq2ei7O30uovociC/K9m+PEA2tfbsAeIy0ZmI05tbPzMZq+XjJX/queqUybVZpuvTw
         R2hGXJ1CQAlk9BkzV5yzOuRqBM9WTyw7dxSi4MaduzakjEU6sA+2cWu+GbQKi4VxOyXl
         atp2FzPvSeK4GwM4fvU2ju1LvNshU+vBnhYa5ijCvtKZBcyIjdt1Gi+ttQOjkAJpCiSr
         I09oQH0Y/PWJgS2FKqbWmTzBuScRokkFeC4/bdAp1Be05l79UJTBNBQdezIPXG+38MZu
         Ug6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776669651; x=1777274451; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3PoSEU0MLplYolt2G+sl9yrRfXWDBd5tOwRXHg21c/Y=;
        b=pZi0S1Ay6V3CWAHE90/BREY2kQzQzvjS77NBbnOQIXiuhUfGJErMP2eFlVveBt48gR
         CKciLAryiAdAgAwVHpMbD9Aj0uxBOrKCPNHoKkPC7JnALeYQxNcF+N2AwKSwG62Eu1Ji
         /b4i8gCGSZoKT1WsqL2dkHJSHbPN8XMOhbNdOk79GwWpYKCYkncAh/LXYWrvCFNFFN4X
         MTDLTELgUW1cXQofwVIgIdo0p6PEvQQ0sgTDld/mSVjyAyFS911Msv7gVkFMlUANf6FG
         2IXcMwc798hGeydqYLfaxrfKDtz5NpHLy82AcivohHC3tBhsHYC/R9fhMq1+cT25am3a
         +3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669651; x=1777274451;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PoSEU0MLplYolt2G+sl9yrRfXWDBd5tOwRXHg21c/Y=;
        b=chTgoWbsT1qdBoZNchwbGOW+pcey3jQqeqRzWrP0oOGNwalXFOI/P9ojGvB+Qln8FM
         WZ+ogWYIBPkOIIXUFnmhhr8TM0WLYAV9eeMFx6kPnbGnALcDT+cKBdQcV3ytNFbKBIcy
         1DdRbl5Guma1TvTXalK3S1mDP8Ry2cMjTLlxOThxYKiGC+bLQKEwsKbBCT44C9Lw4m6p
         5suujYVPoGUzvwwZfhlhRyeJIpsmKysbnc7hJb48AuhCI7pmISXyYdZTit+dgGaTLaWo
         plK9k552QeqAXYyI7rRj6gFYiTxfgB5CIN37X+5hNmKk5wWPFglPRtYRmytzTk4mtrE+
         IQ+A==
X-Gm-Message-State: AOJu0YwcmY+zYsj7U4rrCApgivsJGHGokUgdwNU7c3NeyKtffET+k32B
	+jU9WEl8N5cW294tpM4zQ/Z4lJPuh1GpY9lXHhqqXZN+jYuZUyCbMrO2zEMo9FhJwP+JFvJ8UUO
	VwW5qS8mbf2rsAyrfHQFwLfqkIQGFDdg6XcJp7Ds=
X-Gm-Gg: AeBDietKeWPbeHmPPUUdltf2Bid9GkthhIc74owvNkR3EBniL4Wb38QgNeQkn0EixIz
	jMJ6V+xtuArZ5wVEoSUODCEERW1bFGNkXNmB2ZalkMuZjkDrLwnr/qUwgI4lWzjL8uK2CkGxwv7
	4HBZQvOwokdP8pYFMkrG4+hGBKnAlXARZhF+jSOJRN5tYK+7ED5rV0JM/vanuZKnB+2BSm5LtUd
	xIhlZzMXVNnVgks/+jnCGVrsyJPnPq4Ei7E9KkjBM0FmxfP1OHD1L7REk/2fypDieJwW5iGzVpB
	Xvb/4qYbQzvyi7jrvA==
X-Received: by 2002:a17:907:97d1:b0:ba7:69eb:7f12 with SMTP id
 a640c23a62f3a-ba769eb83bfmr145831866b.40.1776669650771; Mon, 20 Apr 2026
 00:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 20 Apr 2026 09:20:00 +0200
X-Gm-Features: AQROBzDa425TFRoYLZ5wMNuIoh2SGyMqqt9NbiKHW5GeRUfT4dkERx_Yg2sZzCg
Message-ID: <CAPJSo4WEkdPfLUcMN3t1Ea2ZTp3Ga6WEo=Y4UJ+FrEzidwxRGw@mail.gmail.com>
Subject: Eregex support in nfsmount.conf for [ Server "Server_Name" ]?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20966-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 40C9D427AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Would it be possible to support POSIX extended regular expressions for
[ Server "Server_Name" ]?

It is a great mess with /etc/nfsmount.conf when you have Kubernetes,
or just lots of NFS servers, say 15000 NFS server machines. POSIX
eregex matching would reduce the pain a lot.

Lionel

