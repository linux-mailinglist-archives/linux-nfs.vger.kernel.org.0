Return-Path: <linux-nfs+bounces-7356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFA9AB014
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230DA1F23A6A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918019EED2;
	Tue, 22 Oct 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=s7mon@web.de header.b="eQh0koXE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20719DFA2
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605058; cv=none; b=Nuz1j2vXJnkhT3Mm24nO8cZpsfAlhSbyyXQR8Mc0wF1UPRs51uhFbRcHSYbD18Gf3GC/3WVMUigKcw6aTC0xlDAVDGBZq9GQAaOLpWeFoczffD33E96nxpEduyDSK8N40EwqpqRcXVTmHuxhFIozag/eI7GDzpcktrBkNv5+gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605058; c=relaxed/simple;
	bh=zUxWEo/zXQoiCN2GBrgfEXDDoZJ4DVP0c3fN4/npow0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=S2RiWeM5acrX3b4zysZ0pS4ZuGwOQiWPa1dOYta8XiINHhgZqMHMhnXj55DZJeeBqyqirupwGwcYgQ0jHtLWhCU2/mEMAu90ZWcZ7cCe4tABGwAhqQw2YwCMd5sh6TKIs5YfevgQMwLhxINWWYOH7sNynl3MnCrTsh/VXPLoHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=s7mon@web.de header.b=eQh0koXE; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729605048; x=1730209848; i=s7mon@web.de;
	bh=sqS0W8o4wG1r5s4nEcPC9CdxxwCUK90jp+hNw2ZxZs0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eQh0koXEDkpb8lcDel5rdP/laNWotPI/YVx7v3F4fUPLw1aFl9XNshrxCIkpC/4q
	 ilZ83IDjc4LPokYgAZKR9wtP/sJ4DEnfojqYfVhO+4a5L52imwvu45WaxsRc/jxc0
	 49D0d03aHPtnSLnCErll+xJBbRZe9M+Rd5kYu3ytdhYYRlsihsewJMGokuLqplIKH
	 Od8NoppUEiN/jBF85qZRbXiLxBPqu/NpkMDxnBu8jmb4MydcC/JXSoHcREyxERyZ2
	 Hyx43fLctChMLsn2+EgNJEfOxE6F4CAOE8v+hhdINVhxZgh5sJOxsusF/dtv2eZ8d
	 D+rNpXKvU3r4IV0Iww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from jen ([217.86.124.131]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1tGWyF3lqK-00M6B2; Tue, 22
 Oct 2024 15:50:47 +0200
Date: Tue, 22 Oct 2024 15:50:47 +0200
From: "Patrick M." <s7mon@web.de>
To: linux-nfs@vger.kernel.org
Subject: nfs xprtsec conflicting with squashing
Message-ID: <20241022155047.0b73b6b3@jen>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gsFqKsDddKiP/juRwHoNjzdmOj1klbNxnm19bCy6hqlumOTMYS
 mp3z9YgU1DTr+loWpiZ+UiCGc/cEPH2oNRQtbIiBs32KYithtl4390Yr/+aBxnR4rrAlAuz
 2t6H6++rWwWfAek0+VG6pCEAorKLsUD5MY2/002YlLVlHAPtM6fEpFE85eLftMLe6gj6aDX
 p2vpvwqehgELsxSA1uAug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RbRRxMAUudo=;7zQEBHn+zefjPjjYco3o27uWczi
 /yFWgBMih/32oC1DjMhkaqEakKCdfVsiLrCcliPJR7SHyUTJ8MjyiwtwUz0f66ZHo6WQos5eX
 YxZ/t0BgrdGe29hg4kUy0i5oubOEUqM5P/DzKB6ACyEoxJujootxv6YSeCBXri029doMp74E5
 KKL1X3mfL7OsSOmVxBNV6R8oye2QhYs4NsIDDE8E2RHdMmt/ku1kh4wqMiitbCbpdycLl6f5D
 vkiT+m6bOA4YjWy4Cu8JmklB/n3+HZqD8XLqPBHLd25Gs5V704EkT18+tJtDzHbw0NyO04BDi
 OSEP/vtfjA56EkPOUXTRga+SuM9NEVPnfrpXIzE2ncyG7OZFIcInjQGIFSJCqzNbCpjNI0hY+
 zGw9KHqJ61TR5XFQ81isiOoBV1OUkSWY85v+KF+I4Ua4SyDVJglEQrE0xpGpGtgRXdBTuQZiR
 2ngqhJthfViYDRNJk9vSfSa7T+hENHSgg9dMU9KorhM/4YY99zS32EhQuqE9IKJ6f4HvK2XlX
 VxAH5JEmIcS0ZxjYTt24M2OZqQuUcTPI3hwBkQVXPlrhbX2I1ePTW/HluGV76jmRnhCxTdZ7J
 xTgVhEqige4ssFysyYMskoAKbTQa6Rm0cQ6BYzIB1KoOKI20u6prvSK8AvT461aj10i5P0RE1
 LWL5l2aV7mMl7MC1cIQY48EiqNqcgszQqt8V3U65G3BcAE5clJl2sHcbRRabjakKeLihBPuam
 xpYgHMyK9u2Y6ElTcW9GsnwHecz5NizyMY9gvkyMTDFMuRC9LVkmmBqM9k2aSkwyias2eNhHn
 S7jjeI/0bhYciBu875/XMirQ==


Hi there,

tried switching to nfs with kernel TLS (mTLS to be specific).
Without xprtsec i was able to use the following options on exports

"rw,async,all_squash,no_subtree_check,anonuid=3D1000,anongid=3D100,fsid=3D=
6,sec=3Dsys"

but both the squashing/mapping-ids seems to conflict with TLS and i wanted=
 to understand if this is by intention or a bug.
And if it is by intention of course why - because in my understanding auth=
 and encryption of the mount itself would not contradict with the mapping =
functionality.

I now use "rw,async,no_subtree_check,fsid=3D6,sec=3Dsys,xprtsec=3Dmtls" an=
d it is working. Using no_root_squash also seems to conflict.

Keeping ID-Mapping i get this on client side

	mount.nfs: Operation not permitted for server:/mnt/target on /mnt/target

And nothing i could relate as cause on server side (happy to provide speci=
fic logs if needed, even with nfsd or rpc flags with rpcdump i could not s=
ee a cause).
Tlshd showed also succes in both scenarios (handshake successfull) and i c=
an use all options as well if i remove the xprtsec on server side.

Client:
Linux 6.11.
nfs-utils-2.7.1

Server:
Linux 6.5.52
nfs-utils-2.7.1

Sorry if i missed this in documentation, if so i'd appreciate the hint whe=
re i should look in detail
and thanks for this feature!


=2D-
best regards
Patrick M.

