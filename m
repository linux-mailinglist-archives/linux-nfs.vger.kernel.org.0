Return-Path: <linux-nfs+bounces-5034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015393B4C1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2964D1F24EBE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EE2837F;
	Wed, 24 Jul 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trodman.com header.i=@trodman.com header.b="N6GNborc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from xklwu-2.xen.prgmr.com (xklwu-2.xen.prgmr.com [71.19.154.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D82595
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.154.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837858; cv=none; b=IpFsLIgtYc3gnhLdLP2f4udPYL0INmPszjTLGK6eChtgBngg7dDljhe9+Q0zV/ti5vMpn99JgKH04MXrHSkdzKkqiBbA3lO9EYRrpFAzZnOblrnnUXAsxoF3hs8AXR6odaDUbCqXTv9SegNu3sKVlxVU3TNTDfhT7e95YKvLi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837858; c=relaxed/simple;
	bh=9EiXNgcci9CdyqSo+Dw9gPMZHgyRCcctaO22JjLzf2M=;
	h=Message-Id:To:From:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date; b=Z7z9zkmmAlz0KxwYKaNglTt+K/EJgP3S//i7kHhqVVNXO9/j79TgWCx4asYhllCDt+nrS0luqyPFkMljBbW61BNgQkBuAc35OwBz3O7dKX74Z7S31QBhzyl26pgQT5DOPpU37TTsBYshhXfAjZm2vrBu1GiUlR+jQK04udxtR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trodman.com; spf=pass smtp.mailfrom=trodman.com; dkim=pass (1024-bit key) header.d=trodman.com header.i=@trodman.com header.b=N6GNborc; arc=none smtp.client-ip=71.19.154.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trodman.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trodman.com
Received: from epjdn.zq3q.org (epjdn.zq3q.org [71.19.149.160])
	by xklwu-2.xen.prgmr.com (8.17.1/8.15.2) with ESMTPS id 46OGHWQT082116
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:17:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 xklwu-2.xen.prgmr.com 46OGHWQT082116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trodman.com;
	s=myselector; t=1721837852;
	bh=XtMsoTaNw6p/qEOfxVy8PcihS54LKbfhFDnJXVrXSoM=;
	h=To:From:Subject:In-reply-to:References:Date:From;
	b=N6GNborcI5tFuEZw7NA6dR04Hgi5GJ5Gzr96MPz3zBlSO3PgCRt1wmzLCLAnq+Ym/
	 ZVOxuLbrrE2gKAxn+QAQYSwzsADYAweDS2L3dBywu/aEgMvzFO1CJgNriq8YVk1Hc5
	 tYl71LZvGsWh1admT4qV0BrLFZsfLK0EXyToImJI=
Received: from epjdn.zq3q.org (localhost [127.0.0.1])
	by epjdn.zq3q.org (8.17.1/8.15.2) with ESMTP id 46OGHVKY064027;
	Wed, 24 Jul 2024 11:17:32 -0500
Message-Id: <202407241617.46OGHVKY064027@epjdn.zq3q.org>
To: linux-nfs@vger.kernel.org
From: linux-nfs@trodman.com
Subject: Re: recipe/example | nftables for Internet nfs4? << iif enp1s0 tcp dport 2049               counter accept comment "allow nfs"
In-reply-to: <9a8043e5-9f97-45c0-a26f-a882acd1e320@oracle.com>
References: <202407231953.46NJrpWr3811115@epjdn.zq3q.org> <9a8043e5-9f97-45c0-a26f-a882acd1e320@oracle.com>
Comments: In-reply-to Calum Mackay <calum.mackay@oracle.com>
   message dated "Tue, 23 Jul 2024 22:28:21 +0100."
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64022.1721837851.1@epjdn.zq3q.org>
Date: Wed, 24 Jul 2024 11:17:31 -0500

On Tue 7/23/24 22:28 +0100 Calum Mackay wrote:
>On 23/07/2024 8:53 pm, linux-nfs@trodman.com wrote:
>> I have a fedora server on Internet sharing out NFS; working ok for 3+years w/firewalld.  I'm going w/pure nftables on a new server. Does anyone have a recipe/example for setting up an NFS server using nftables?
>
>I'm still stuck on iptables, but I imagine it ought to be something 
>simple like adding this to your NFSv4 server's inbound chain:
>
>	tcp dport 2049 accept
>
>assuming you have a default accept policy on your outbound chain.
>
>That's just for NFSv4 over TCP, of course. And you might want to add ct 
>connection tracking state, etc.

Thank you Calum.

As you suggested, I added:

iif enp1s0 tcp dport 2049               counter accept comment "allow nfs"

I then tried mount -v ... and it got farther but failed

    mount.nfs4: mount(2): Permission denied

Then I restarted nftables.service, It worked!

--
thanks!
Tom

--8<---------------cut here---------------start------------->8--- 
# cat /etc/sysconfig/nftables.conf |_rmcm ## comments stripped. enp1s0 faces Internet
flush ruleset
table inet filter {
    chain input {
        type filter hook input priority 0;
        iif enp1s0 tcp dport {ssh}              counter accept comment "allow ssh"
        iif enp1s0 tcp dport {http, https}      counter accept comment "allow http, https"
        iif enp1s0 tcp dport 2049               counter accept comment "allow nfs"
        iif enp1s0 tcp dport {smtp}             counter accept comment "smtp"
        iif enp1s0 ct state {established, related} counter accept comment "allow established Internet packets"
        iif enp1s0 counter drop comment "dropped Internet packets"
        iif enp2s0 accept comment "allow local packets"
    }
    chain forward {
        type filter hook forward priority 0;
        iif enp1s0 oif enp2s0 ct state {established, related} counter accept comment "allow Internet est/relat"
        iif enp2s0 oif enp1s0 counter accept comment "allow lan to Internet"
        iif enp1s0 drop
    }
    chain output {
        type filter hook output priority 0;
    }
}
table nat {
    chain output {
        type nat hook output priority -100;
    }
    chain prerouting {
        type nat hook prerouting priority -100;
    }
    chain postrouting {
        type nat hook postrouting priority 100;
        ip saddr 10.164.123.0/24  oif enp1s0 counter snat MY_SERVERS_INTERNET_IP comment "snat/static ip"
    }
}

