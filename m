Return-Path: <linux-nfs+bounces-21401-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBzkNbRp+mlbOwMAu9opvQ
	(envelope-from <linux-nfs+bounces-21401-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 00:05:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508584D42FC
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 00:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2905E30157C2
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B021FC110;
	Tue,  5 May 2026 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Huef4BUJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92815FA81
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018736; cv=none; b=gbb0srxQ5D5YtyQ5ufgYbyrXjdrYyzO5Ub8f9JGqoLRL47/J+CEa+Db3Dp/AjhIPB58x0xg2eb+OXp19BQJ/yJIuyP3lKVmI1xpG9bCNuf4Ut416aBt7wpqY6tpBSj2JLNVTooI6Q/V/WsBfHLM8dxMZbACCnuvkyt0doMv6+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018736; c=relaxed/simple;
	bh=keILwDPQkW55NHL2F5+RiZ0D8yyOVYyoXLejxcl3tac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeFuOOVLEhOdBOkPXU1YMY718lKz9Vv4GSLRmk9tl2NqU24Ck1QN07NC47ErMR0K+fqVeRGQtK1i1HLKebEI+8/iRt+fsX/wPv/etAndRQNbu20TBZZv8XxaHWdYB4FHR7Vq4YFxy/yP0lakmHFrH3gWewwpfCSv5NYc0zok6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Huef4BUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA3BC2BCB4;
	Tue,  5 May 2026 22:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018736;
	bh=keILwDPQkW55NHL2F5+RiZ0D8yyOVYyoXLejxcl3tac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Huef4BUJv4Sgje5Vx7RcnYu1tL29dkIdHbjDhoCms7nxq7Iv0VgFPvWeEZRU0V26h
	 by/H9dMzrObz7Ps02xf8tkFMIgR+Dw0xzW/T9ASuvlg6g6QD1AVFO9aj4Ad7Z6Vs+M
	 0GJoix6x1nG19RlpBs/E/aDf/g6xRgkE45jhrl0H+8yit4hUwnryE9tN9TC8b0Jn9s
	 +v/AQEnThXjcL85f0L9RAQnps+V+UmMQh2RrnW+MwDFh8Dcb47Zg+RDBVrFnEiCL6c
	 Ooq+23ub6MJwsVuAZBC8VC6jc476h2Ba55XT8KJbFc1ORcob+MR2hj6abpvBRXqIh8
	 iqk1YmLdexgiw==
Date: Tue, 5 May 2026 18:05:34 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: ben.coddington@hammerspace.com, jonathan.flynn@hammerspace.com
Subject: Re: [RFC PATCH 0/2] svcrdma: avoid OOM due to unbounded
 sc_send_ctxts cache
Message-ID: <afpprmApzykJFPci@kernel.org>
References: <20260505215535.68412-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505215535.68412-1-snitzer@kernel.org>
X-Rspamd-Queue-Id: 508584D42FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21401-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[svcrdma-wq-lag.bt:url,claude.md:url]

On Tue, May 05, 2026 at 05:55:33PM -0400, Mike Snitzer wrote:
> Hi,
> 
> I drew the short-straw by having to take a hand-off from Ben on work
> he started with Claude yesterday in response to a really crazy OOM
> situation that hits like a freight train at one large customer's
> install that currently has 121 NFS clients and 9 NFS servers, all
> connected with RDMA networking.  Working with Jon Flynn, to bound the
> problem a bit more we later scaled the testing down to 15 clients
> reading from 1 server using 16K O_DIRECT reads.
> 
> So I imported Ben's CLAUDE.md that he handed off and carried on, with
> patch 1/2 we're able to avoid OOM killing the NFS servers (each with
> 128GB) -- with the 16K test workload memory use would grow from ~12GB
> to exhaustion (128GB) within ~10 seconds of starting the test.
> 
> The 2nd patch in this series provides a diagnostic svcrdma-wq-lag.bt
> bpf script that Claude suggested -- I just dropped it in
> Documentation/filesystems/nfs/ but it isn't intended to go upstream.

Here is svcrdma-wq-lag.bt output before we capped in _get (short run
because otherwise we'd have hit OOM, but shows the flood of
sc_send_ctxts that only become visible once the test was killed at
17:45:36):

# ./svcrdma-wq-lag.bt
Attaching 7 probes...
svcrdma_wq lag diagnostic. Per-5s rates.
Watch for @wc_send_rate >> @release_rate during the test
(workqueue backed up -> ctxts pinned in queue items ->
 Ben's cap can't see them).
Ctrl-C to exit.


17:45:06  wc_send=0        release=0        get=0        capped=0

17:45:11  wc_send=1984617  release=1571458  get=1916504  capped=0         queue/release ratio=1

17:45:16  wc_send=2176680  release=1698697  get=2097454  capped=0         queue/release ratio=1

17:45:21  wc_send=2181507  release=1716810  get=2105847  capped=0         queue/release ratio=1

17:45:26  wc_send=2178462  release=1728112  get=2104069  capped=726       queue/release ratio=1

17:45:31  wc_send=2158883  release=1714519  get=2092136  capped=205       queue/release ratio=1

17:45:36  wc_send=1029461  release=1585039  get=996644   capped=757304    queue/release ratio=0

17:45:41  wc_send=0        release=3092605  get=0        capped=1492238   queue/release ratio=0

17:45:46  wc_send=0        release=1000663  get=0        capped=1000764   queue/release ratio=0

17:45:51  wc_send=0        release=0        get=0        capped=0
^C


And here is svcrdma-wq-lag.bt output with patch 1/2 applied (full 5
minute run):

18:13:21  wc_send=1151440  release=1148610  get=1150980  capped=0         queue/release ratio=1

18:13:26  wc_send=2125499  release=2149303  get=2107227  capped=0         queue/release ratio=0

18:13:31  wc_send=1780821  release=1792233  get=1759546  capped=0         queue/release ratio=0

18:13:36  wc_send=3893061  release=2118765  get=2081403  capped=1         queue/release ratio=1

18:13:41  wc_send=1837599  release=1883821  get=1815453  capped=0         queue/release ratio=0

18:13:46  wc_send=1813727  release=1822876  get=1794087  capped=0         queue/release ratio=0

18:13:51  wc_send=1491464  release=1529370  get=1476924  capped=0         queue/release ratio=0

18:13:56  wc_send=1930254  release=1955278  get=1910046  capped=0         queue/release ratio=0

18:14:01  wc_send=1916374  release=1944863  get=1894205  capped=0         queue/release ratio=0

18:14:11  wc_send=4089684  release=4107873  get=4041449  capped=0         queue/release ratio=0

18:14:16  wc_send=1740066  release=1789864  get=5765163  capped=0         queue/release ratio=0

18:14:21  wc_send=3655551  release=1936245  get=1894173  capped=0         queue/release ratio=1

18:14:26  wc_send=1652813  release=3613434  get=1637738  capped=0         queue/release ratio=0

18:14:31  wc_send=1873398  release=1903780  get=1855887  capped=0         queue/release ratio=0

18:14:36  wc_send=1947061  release=1971983  get=1920987  capped=0         queue/release ratio=0

18:14:41  wc_send=1624716  release=1630181  get=1608404  capped=1         queue/release ratio=0

18:14:46  wc_send=1709804  release=1752711  get=1693828  capped=0         queue/release ratio=0

18:14:51  wc_send=1939672  release=1970791  get=3615177  capped=0         queue/release ratio=0

18:14:56  wc_send=1884914  release=3875602  get=1862209  capped=0         queue/release ratio=0

18:15:01  wc_send=2019244  release=2044366  get=1993761  capped=0         queue/release ratio=0

18:15:06  wc_send=2065910  release=2099472  get=2046106  capped=0         queue/release ratio=0

18:15:11  wc_send=1914899  release=1933756  get=1893723  capped=2         queue/release ratio=0

18:15:16  wc_send=1895244  release=1916124  get=1874634  capped=0         queue/release ratio=0

18:15:21  wc_send=2000953  release=2036536  get=3853528  capped=2         queue/release ratio=0

18:15:26  wc_send=3971332  release=1984930  get=5805016  capped=0         queue/release ratio=2

18:15:31  wc_send=1842215  release=1876278  get=1827305  capped=0         queue/release ratio=0

18:15:36  wc_send=1712031  release=1745388  get=1698252  capped=0         queue/release ratio=0

18:15:41  wc_send=1457677  release=1477376  get=1446707  capped=0         queue/release ratio=0

18:15:46  wc_send=1522972  release=1562257  get=1510851  capped=0         queue/release ratio=0

18:15:51  wc_send=2126919  release=2126524  get=2100919  capped=0         queue/release ratio=1

18:15:56  wc_send=1795205  release=1853495  get=1782554  capped=0         queue/release ratio=0

18:16:01  wc_send=1872737  release=1892789  get=1852457  capped=1         queue/release ratio=0

18:16:06  wc_send=1956552  release=1978503  get=1936808  capped=0         queue/release ratio=0

18:16:11  wc_send=1971408  release=2008768  get=1946069  capped=0         queue/release ratio=0

18:16:16  wc_send=1906940  release=1928668  get=1891132  capped=0         queue/release ratio=0

18:16:21  wc_send=2019228  release=2059320  get=1993856  capped=0         queue/release ratio=0

18:16:26  wc_send=2024263  release=2039861  get=2004786  capped=0         queue/release ratio=0

18:16:31  wc_send=1959046  release=1986165  get=1936975  capped=0         queue/release ratio=0

18:16:36  wc_send=3426760  release=3483327  get=1456324  capped=0         queue/release ratio=0

18:16:41  wc_send=2066845  release=2078503  get=2042898  capped=0         queue/release ratio=0

18:16:46  wc_send=1834131  release=1878182  get=1818034  capped=1         queue/release ratio=0

18:16:51  wc_send=1804133  release=1817222  get=1787677  capped=1         queue/release ratio=0

18:16:56  wc_send=1443325  release=1469384  get=1429495  capped=0         queue/release ratio=0

18:17:01  wc_send=1437236  release=1480771  get=1425373  capped=1         queue/release ratio=0

18:17:06  wc_send=3342896  release=1925346  get=1885982  capped=0         queue/release ratio=1

18:17:11  wc_send=2035328  release=2063539  get=2011609  capped=1         queue/release ratio=0

18:17:16  wc_send=1923583  release=1930805  get=1904366  capped=0         queue/release ratio=0

18:17:21  wc_send=1918902  release=1958907  get=1899028  capped=0         queue/release ratio=0

18:17:26  wc_send=1912808  release=1942152  get=1895315  capped=0         queue/release ratio=0

18:17:31  wc_send=2067295  release=2090789  get=2045747  capped=0         queue/release ratio=0

18:17:36  wc_send=1893866  release=1917954  get=3924985  capped=0         queue/release ratio=0

18:17:41  wc_send=1914595  release=1922461  get=1895841  capped=0         queue/release ratio=0

18:17:46  wc_send=1833010  release=1884469  get=1816313  capped=0         queue/release ratio=0

18:17:51  wc_send=1853085  release=3756671  get=3652976  capped=1         queue/release ratio=0

18:17:56  wc_send=1814888  release=1845390  get=1797898  capped=0         queue/release ratio=0

18:18:01  wc_send=1875252  release=3752430  get=1856752  capped=0         queue/release ratio=0

18:18:06  wc_send=1929648  release=1955900  get=1913162  capped=0         queue/release ratio=0

18:18:11  wc_send=1878956  release=1907828  get=1862308  capped=0         queue/release ratio=0

18:18:16  wc_send=1839023  release=1862031  get=1823009  capped=0         queue/release ratio=0

18:18:21  wc_send=77       release=77       get=77       capped=0         queue/release ratio=1

18:18:26  wc_send=0        release=0        get=0        capped=0

18:18:31  wc_send=0        release=0        get=0        capped=0
^C

