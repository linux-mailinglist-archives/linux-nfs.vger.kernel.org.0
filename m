Return-Path: <linux-nfs+bounces-10570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D1A5E6F9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC75D17A757
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7F1E8327;
	Wed, 12 Mar 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="2u13IcuM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1E800
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816975; cv=none; b=IL2TyFJ2jlmT5BqXvCHVrKd5h299gGNWMycLvz7ueF2Tcuu5qr3lWXopL7cvg3KfrN6D+mAV11tNLDfnBghXMZQJyHU3VQmO1YeCMuB1JB/KRd+WY+kE5+qD7xbPZfeaOEPHlk+DhI6qGJY2/Qk116mn1zzbWPr6k1pYsCAT4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816975; c=relaxed/simple;
	bh=4ALzJ3gu72Fv7zwa+3cP/JD8OBKignKSZReySJqPXYQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=LPhQgB0DFkPIANOngwzOXPH2JxTZIBqxgyl8KeHNmzhUVYtuufdfbqifie7kVGexRGqYs20cdC3igGFrlHjG/QWcxYyhXNSJFBRRZd5uH/MgHlXwAlI3jTDb4AJ4V5nYiKar1ueHu1+5eiVwTJHg0M4Lc1MxFYuPJA5FtGhAUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=2u13IcuM; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id B2812240DB1
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1741816626;
	bh=4ALzJ3gu72Fv7zwa+3cP/JD8OBKignKSZReySJqPXYQ=;
	h=Message-ID:Date:From:Subject:To:From:To:CC:Subject:Reply-To;
	b=2u13IcuMJWI+2POkzlQVYtveE/XcfAbYM04246hccWzza9GPkEApvQ5ZXa/qbTK2g
	 03vairgblBAhyNGaR6TmcmCIDSrI+F77W7QtPtH8J4gee4xHs8JsX8fxoSF+08ngKy
	 bbHdciOmIghBH/KkBwckKf2wSZhqWWWwkQhptoHnKmpWCO1l5G2X4fPIWjaSdt4SUm
	 gAkXG5VZc0DXgEutSMuF/jJILt1WDBE6GCUHuqpxm9PQB0yCN8pT2zJwBhGDJN1TEB
	 Rz7y4/rtdLw/fsqlBXaYBn7OMvaZAsirRtxvrTAcb+HoJauKh4zRmJUDyXw3qQjwWp
	 CHbeDK6YAXjcw==
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix01.mail.de (Postfix) with ESMTP id 9563224058C
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:57:06 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 52437240A93
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 22:57:06 +0100 (CET)
Message-ID: <d27d885e-568c-42b8-a204-2f4a3e949d64@mail.de>
Date: Wed, 12 Mar 2025 22:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, de-DE
From: Tycho Kirchner <tychokirchner@mail.de>
Subject: Parallel shared to exclusive flock conversion blocks forever on
 single NFS client
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2498
X-purgate-ID: 154282::1741816626-24F732C4-E71E3AF4/0/0

Dear NFS kernel developers,
In `man 2 flock` it is documented, that an existing lock can be 
converted to a new lock mode. Multiple processes on the *same* client 
converting their LOCK_SH to LOCK_EX quickly results in a deadlock of the 
client processes. This can already be reproduced on a single physical 
machine, with for instance the NFS server running in a VM and the host 
machine connecting to it as a client.

Steps to reproduce:
- Setup a virtual machine with Virtualbox and install NFS-server
- Create an /etc/export: /home/VMUSER/nfs  10.0.2.2(rw,async)
- Create a NAT firewall rule forwarding NFS port 2049 to the VM
- Mount the export on the host, chdir it and create an empty file:
   $ sudo mount -t nfs 127.0.0.1:/home/VMUSER/nfs  /somedir
   $ cd /somedir
   $ touch foo
- Execute below attached ~/locktest.py in parallel on the client:
   $ for i in {1..10}; do ~/locktest.py foo & done; wait
- Wait half a minute. The command does not terminate. Ever.
- Abort execution with Ctrl+C and kill leftovers: pkill -f locktest.py

Notes:
- According to my tests, from three concurrent client-processes onwards, 
the block quickly occurs.
- Placing a `fcntl.flock(a, fcntl.LOCK_UN)` before fcntl.LOCK_EX is 
enough, so the deadlock never occurs.
- OR'ing `| fcntl.LOCK_NB` quickly results in endless »BlockingIOError« 
exceptions with no client process making any progress. See the also 
attached ~/locktest_NB.py.
- Multiple distributions, Kernelversions and combinations tested, e.g. 
NFS-client KVER 6.6.67 on Debian12 and KVER 6.12.17-amd64 on 
DebianTesting, or KVER 6.4.0-150600.23.38-default on openSUSE Leap 15.6. 
The error was always and quickly reproducible.

Kind regards
Tycho

###___ ~/locktest.py ___###

#!/usr/bin/env python3
import fcntl
import sys
import time

a = open(sys.argv[1], 'r+')
fcntl.flock(a, fcntl.LOCK_SH)
fcntl.flock(a, fcntl.LOCK_EX)
time.sleep(1)

___________________________


###___ ~/locktest_NB.py ___###

#!/usr/bin/env python3
import fcntl
import sys
import time

def lock_nb(lockfile, l_mode):
     for i in range(20):
         try:
             fcntl.flock(lockfile.fileno(), l_mode | fcntl.LOCK_NB)
             return
         except BlockingIOError as e:
             time.sleep(1)
             continue
     print("gave up waiting for lock...", file=sys.stderr)

a = open(sys.argv[1], 'r+')
lock_nb(a, fcntl.LOCK_SH)
lock_nb(a, fcntl.LOCK_EX)
time.sleep(1)




