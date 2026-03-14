Return-Path: <linux-nfs+bounces-20168-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFGdBS9TtWlGzQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20168-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 13:23:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8715B28D1C3
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 13:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E5D3023A4F
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336171AF4D5;
	Sat, 14 Mar 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf+2gEM4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC017DE36
	for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490988; cv=none; b=NAARBB4Xn3IvsQylOBYmGNATO3JRVulOqJApOvajSOKcB99Yu60Whaix22oGUCESSe4PU+Gq+mee5EDj2YnPjDLsnxILo4xXJm8+Ag6QqbTCVjn8GZQiU84z9i8fRsncIu8j2VfzbebQYaQErZkSI/JXoEoHyVunBxIbnlzFQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490988; c=relaxed/simple;
	bh=buPks5PBxGSwGL8vkwFfugwS6GFMYIcHl01QQPzIf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UTiE7c6nhOXiKzzFCtzN2Ma66OhHawzm6Ir0KBDmWcw1aaaGApZ1hSNIGqRkFny1Pj4JmCyWBctR6O8mMHZ0fR4YXdWJ/5r7vUtG79WbtYM3CgzTdMzg69yUQ/wPAzMKdOaigPsqjtQlcwzbczeylfPf2c0x5wrfZICbx33+p1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf+2gEM4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485409ab264so21365135e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773490984; x=1774095784; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AJjipUbO1IhGzwZcApN0bsywZyvfnfUBT0/hLHzwY3c=;
        b=Uf+2gEM4LFk2hRixkKfmp4KsCqIPn2d4QTZlUEs7wDieaZQzAmfJmsIhaY0Z0AkPMB
         x79PJ0ZOx9j062BHhZuWyLQBRV//bypdTbhoFM5myFGIqnFiJcctYn+oGXcv7kwW0Igf
         +vtC7h+LGqusBX1u78GGPauT3kdWPXA5xZv0aHq3Av6W/3RzYbVsSg8Ny/VyaJp9jFMw
         ts3JprTlZvoZPTisrMLciuf4RiOKVHKse1VDq0oN0K8kKG4ZKo8skvRh8OdjRaj48lKb
         HjIGdkYqPIzgs4rpSw+kHzQ7+kj6o616u1xEsS3ubVAnmPWXHjJutdRCdCDC0MZDE/fh
         x8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773490984; x=1774095784;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJjipUbO1IhGzwZcApN0bsywZyvfnfUBT0/hLHzwY3c=;
        b=DlA8fGQE9Oo2CFVtuj6m8LcSqFyq36rPKZwGW+pI9MstJ5JPP2fdvhR9GqA1fzvhHq
         G+ft7DYMqw0txgBhN2+3iiS2rtRNVg54qEzGX5Qoi5zWbtn2ZWVPib6nJlW4D7sF6f7B
         PzSt3xpbj3Li3Z+8jQaneumpkCrfPCNVkwaQz9inqG8MozAcR6AuVyJ/F1k3dLLh5BMN
         nhRDOLVX6UyJ3HA5W9xvI869LwIYYKSk8A4mjrPN3b00smBndQh7Nyxtb3fiAalYm79f
         DjKdmcILbk/eoIF1PSgheymVZy63ehucrxaLFo0lokTQC4nvD8jo4poH90h9LByWOLyN
         hZcA==
X-Gm-Message-State: AOJu0YzZ1Snj6+kuUs2Cnneezh9VRJwd10ZHkhTmsyLudbGKLjiKQA4L
	pG7+W4zsMLauyH1f/03FawxvWOfmblzbm4jFxBeifn3+wRqa0VS4J8zj
X-Gm-Gg: ATEYQzymPB/cZjk39321n6JSZg9IQ3B0ZC1m7LvbYWcCvg1ftUYgNuxZ22oIKfMhMGO
	5n7xsy/R+5ajl+fZ6RIBJ24RugmpbFvkCMrd+SUSom7JsaY47rlw0XAhElwF5bMBtrfGkUTgE7T
	ZcSMQZiR/poUgcA8GQzZwgmkA9WTcqemfGOszBkL/Jxx7KXdzpPDiyxlYQWFz/FIqxRXRoU7AMz
	e67p15XnuZ/ThHQnmksBzGEQRw1kmEg5Ay9Qp/MZjxXeg7VeGm7GZv1IbsxrBwk3Z4a9mdiUrUJ
	9ewZI+wu6KGO7o9w/bQT4jSAxhEZ+i5FUCE8n1CpKcLCovfCRtvt0PTIfpXHkf8X/9c+PurBJdG
	vpJKJoa5moydyI9+pBfPVK5gU2IqmNNDI86NXn0Yk1XDUZfvKjwYULaJa8T4KceQlu7N1fw3Tqc
	fdoeiKGWMZTl0JEoV2B3+FTkXNWJaMSFNfjwAAwViQjBr4fGAYM3vuuoqnIc0=
X-Received: by 2002:a05:600c:8488:b0:485:3b4a:f707 with SMTP id 5b1f17b1804b1-48555b2c89fmr99738645e9.10.1773490984178;
        Sat, 14 Mar 2026 05:23:04 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm734044495e9.2.2026.03.14.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 05:23:03 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 77473BE2EE7; Sat, 14 Mar 2026 13:23:02 +0100 (CET)
Date: Sat, 14 Mar 2026 13:23:02 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Maik Nergert <maik.nergert@uni-hamburg.de>,
	Valentin SAMIR <valentin.samir@magellium.fr>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, 1128834@bugs.debian.org
Subject: [regression] Large rsize/wsize (1MB) causes EIO after 2b092175f5e3
 ("NFS: Fix inheritance of the block sizes when automounting")
Message-ID: <177349021750.3039212.10211295677877269201@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20168-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8715B28D1C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Control: forwarded -1 https://lore.kernel.org/regressions/177349021750.3039212.10211295677877269201@eldamar.lan
Control: tags -1 + upstream

Hi Trond, hi Anna

In Debian we got reports of a NFS client regression where large
rsize/wsize (1MB) causes EIO after the commit 2b092175f5e3 ("NFS: Fix
inheritance of the block sizes when automounting") and its backports
to the stable series. The report in full is at:
https://bugs.debian.org/1128834

Maik reported:
> after upgrading from Linux 6.1.158 to 6.1.162, NFS client writes fail with input/output errors (EIO).
> 
> Environment:
> - Debian Bookworm
> - Kernel: 6.1.0-43-amd64 (6.1.162-1)
> - NFSv4.2 (also reproducible with 4.1)
> - Default mount options include rsize=1048576,wsize=1048576
> 
> Reproducer:
> dd if=/dev/zero of=~/testfile bs=1M count=500
> or
> dd if=/dev/zero of=~/testfile bs=4k count=100000
> 
> On different computers and VMs!
> 
> 
> Result:
> dd: closing output file: Input/output error
> 
> Workaround:
> Mount with:
> rsize=65536,wsize=65536
> 
> With reduced I/O size, the issue disappears completely.
> 
> Impact:
> - File writes fail (file >1M)
> - KDE Plasma crashes due to corrupted cache/config writes
> 
> The issue does NOT occur on kernel 6.1.0-42 (6.1.158).

I was not able to reproduce the problem, and it turned out that it
seems to be triggerable when on NFS server side a Dell EMC (Isilion)
system was used. So the issue was not really considered initially as
beeing "our" issue.

Valentin SAMIR, a second user affected, did as well report the issue
to Dell, and Dell seems to point at a client issue instead. Valentin
writes:

> We are facing the same issue. Dell seems to point to a client issue:
> The kernel treats the max size as the nfs payload max size whereas
> OneFs treat the max size as the overall compound packet max size
> (everything related to NFS in the call). Hence when OneFS receives a
> call with a payload of 1M, the overall NFS packet is slightly bigger
> and it returns an NFS4ERR_REQ_TOO_BIG.
> 
> So the question is: should max req size/max resp size be treated as the
> nfs payload max size or the whole nfs packet max size?

His reply in https://bugs.debian.org/1128834#55 contains a quote from
the response Valentin got from Dell, I'm full quoting it here for
easier followup in case needed:

> I have been looking at the action plan output we captured.
> Specifically around when you first mounted and then repro'ed the
> error.
>
> Looking at the pcap we gathered, firstly, lets concentrate on the
> "create session" calls between Client / Node.
> Here we can these max sizes advertised - per screenshot.
>
>
> Frame 17: 306 bytes on wire (2448 bits), 306 bytes captured (2448
> bits)
> Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> 613, Ack: 277, Len: 240
> Remote Procedure Call, Type:Call XID:0x945b7e1d
> Network File System, Ops(1): CREATE_SESSION
>     [Program Version: 4]
>     [V4 Procedure: COMPOUND (1)]
>     Tag: <EMPTY>
>     minorversion: 2
>     Operations (count: 1): CREATE_SESSION
>         Opcode: CREATE_SESSION (43)
>             clientid: 0x36adef626e919bf4
>             seqid: 0x00000001
>             csa_flags: 0x00000003, CREATE_SESSION4_FLAG_PERSIST,
> CREATE_SESSION4_FLAG_CONN_BACK_CHAN
>             csa_fore_chan_attrs
>                 hdr pad size: 0
>                 max req size: 1049620
>                 max resp size: 1049480
>                 max resp size cached: 7584
>                 max ops: 8
>                 max reqs: 64
>             csa_back_chan_attrs
>                 hdr pad size: 0
>                 max req size: 4096
>                 max resp size: 4096
>                 max resp size cached: 0
>                 max ops: 2
>                 max reqs: 16
>             cb_program: 0x40000000
>             flavor: 1
>             stamp: 2087796144
>             machine name: srv-transfert.ad.phedre.fr
>             uid: 0
>             gid: 0
>     [Main Opcode: CREATE_SESSION (43)]
>
>
> And the Node responds, as expected confirming the max size of
> 1048576.
>
>
> Frame 19: 194 bytes on wire (1552 bits), 194 bytes captured (1552
> bits)
> Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> 321, Ack: 853, Len: 128
> Remote Procedure Call, Type:Reply XID:0x945b7e1d
> Network File System, Ops(1): CREATE_SESSION
>     [Program Version: 4]
>     [V4 Procedure: COMPOUND (1)]
>     Status: NFS4_OK (0)
>     Tag: <EMPTY>
>     Operations (count: 1)
>         Opcode: CREATE_SESSION (43)
>             Status: NFS4_OK (0)
>             sessionid: f49b916e62efad36f200000006000000
>             seqid: 0x00000001
>             csr_flags: 0x00000002,
> CREATE_SESSION4_FLAG_CONN_BACK_CHAN
>             csr_fore_chan_attrs
>                 hdr pad size: 0
>                 max req size: 1048576
>                 max resp size: 1048576
>                 max resp size cached: 7584
>                 max ops: 8
>                 max reqs: 64
>             csr_back_chan_attrs
>                 hdr pad size: 0
>                 max req size: 4096
>                 max resp size: 4096
>                 max resp size cached: 0
>                 max ops: 2
>                 max reqs: 16
>     [Main Opcode: CREATE_SESSION (43)]
>
>
> Now if we look later on in the sequence when the Client sends the
> write request to the Node - we see in the frame, the max size is as
> expected 1048576
>
>
> Frame 747: 1998 bytes on wire (15984 bits), 1998 bytes captured
> (15984 bits)
> Ethernet II, Src: SuperMicroCo_1d:7d:b2 (ac:1f:6b:1d:7d:b2), Dst:
> MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a)
> Internet Protocol Version 4, Src: 172.22.1.132, Dst: 172.22.16.29
> Transmission Control Protocol, Src Port: 810, Dst Port: 2049, Seq:
> 1054149, Ack: 6009, Len: 1932
> [345 Reassembled TCP Segments (1048836 bytes): #84(1448), #85(5792),
> #87(5792), #89(1448), #90(1448), #92(4344), #94(4344), #96(2896),
> #98(1448), #99(2896), #101(4344), #103(4344), #105(1448), #106(1448),
> #108(2896), #110(1448), #111(2896)]
> Remote Procedure Call, Type:Call XID:0xb45b7e1d
> Network File System, Ops(4): SEQUENCE, PUTFH, WRITE, GETATTR
>     [Program Version: 4]
>     [V4 Procedure: COMPOUND (1)]
>     Tag: <EMPTY>
>     minorversion: 2
>     Operations (count: 4): SEQUENCE, PUTFH, WRITE, GETATTR
>         Opcode: SEQUENCE (53)
>         Opcode: PUTFH (22)
>         Opcode: WRITE (38)
>             StateID
>             offset: 0
>             stable: FILE_SYNC4 (2)
>             Write length: 1048576
>             Data: <DATA>
>         Opcode: GETATTR (9)
>     [Main Opcode: WRITE (38)]
>
>
> However we then see the Node reply a short time later with (as below)
> REQ_TOO_BIG - meaning the max size has been exceeded.
>
> Frame 749: 114 bytes on wire (912 bits), 114 bytes captured (912
> bits)
> Ethernet II, Src: MellanoxTech_bd:8c:7a (c4:70:bd:bd:8c:7a), Dst:
> IETF-VRRP-VRID_3f (00:00:5e:00:01:3f)
> Internet Protocol Version 4, Src: 172.22.16.29, Dst: 172.22.1.132
> Transmission Control Protocol, Src Port: 2049, Dst Port: 810, Seq:
> 6009, Ack: 1056081, Len: 48
> Remote Procedure Call, Type:Reply XID:0xb45b7e1d
> Network File System, Ops(1): SEQUENCE(NFS4ERR_REQ_TOO_BIG)
>     [Program Version: 4]
>     [V4 Procedure: COMPOUND (1)]
>     Status: NFS4ERR_REQ_TOO_BIG (10065)
>     Tag: <EMPTY>
>     Operations (count: 1)
>         Opcode: SEQUENCE (53)
>             Status: NFS4ERR_REQ_TOO_BIG (10065)
>     [Main Opcode: SEQUENCE (53)]
>
>
> Why is this?
>
> The reason for this seems to be related to the Client.
>
> From the Cluster side, the max rsize/wsize is the overall compound
> packet max size (everything related to NFS in the call)
>
> So for example with a compound call in nfsv4.2 - this might include
> the below type detail which does not exceed the overall size 1048576:
>
> [
> COMPOUND header
> SEQUENCE ....
> PUTFH ...
> WRITE header
> WRITE payload
> ]     (overall) < 1mb
>
>
> However the Client instead uses r/wsize from mount option, as a limit
> for the write payload.
>
> So with the same example
> COMPOUND header
> SEQUENCE ....
> PUTFH ...
> WRITE header
>
> [
> WRITE payload
> ]    (write) < 1mb
>
> But overall this ends up being 1mb + all the overhead of write
> header, compound header, putfh etc
> Puts it over the channel limit of  1048576 and hence the error
> returned.
>
> So it seems here the Client ignores that value and insists on the
> WRITE with a payload == wszie; which in total with WRITE overhead and
> all other requests in COMPOUND (PUTFH, etc) exceeds maxrequestsize,
> which prompts NFS4ERR_REQ_TOO_BIG.
>
>
> And as you can see, once you reduce the size within the mount options
> on the Client side, it no longer exceeds its limits.
> Meaning you don't get the I/O error.

So question, are we behaving here correctly or is it our Problem, or is the
issue still considered on Dell's side?

#regzbot introduced: 2b092175f5e301cdaa935093edfef2be9defb6df
#regzbot monitor: https://bugs.debian.org/1128834 

How to proceeed from here?

Regards,
Salvatore

