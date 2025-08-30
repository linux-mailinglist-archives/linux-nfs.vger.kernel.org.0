Return-Path: <linux-nfs+bounces-13958-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE823B3CE44
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48092053FC
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73322D5C92;
	Sat, 30 Aug 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrOLhLC8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A9274668
	for <linux-nfs@vger.kernel.org>; Sat, 30 Aug 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575535; cv=none; b=b+V4R1olTPjwX73GZH7SidRd9W+om8uDkmuUHeBOC6VLgSNg5mmiQbCnEq5rNJ5M+SSvATaNacJ5Xg8Gmos4JZOjV75tHmAiQ/03A73SEA5RzCobm67D/+lepTi3uiOCHGKIvDb3ez/I+aDYuftJk08e1ZdHbqScPLaoVxRTO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575535; c=relaxed/simple;
	bh=438F2l4k2opRy9C8On9iglYjSO+0GyCLuR6FAz0xi24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn1zIhE6bI7azWplTZ6hF0qM7KLuYxSR3CwuNmZDjTTZ7cPxP3aYnsMdJGcSoqO7m/jK6zn3FWse/WEt/HCp8mgWyw0bQVOrGFhPkRXIPPneH30Cse/t5YLB/3tf4bsXiIG5k9WuBWuHbCzKWHIaCKPtx/bwXh93a0h6zP3WUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrOLhLC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFBEC4CEEB;
	Sat, 30 Aug 2025 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756575535;
	bh=438F2l4k2opRy9C8On9iglYjSO+0GyCLuR6FAz0xi24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrOLhLC8n820B8V/JBR3M9T4AnsQTXpaMtQ3UsoEtPNkakfY4JMvNYkazM9pWqAOT
	 XiM+4r9fFZ3EgqDGhCofJ0ZafQXABR26WSGwEPGFcZyB4T3efWitxLTbzHMd/zZ2M9
	 zPXk+ka71WeL0DvGSPJY/ZqWwGlu9wwaLk/pNmbovN2muTPMashczJwq12Qx87IlAg
	 uQg+eYRY5dMpxRr5byha4rycwA9vGVeYCuBhNo8KnuIiADpK9k38MNMK0hujCKAGBY
	 CfzLgYbRU6YPOmOJO8oYRV91yVohcM68a+ScgXRWm19C2kjEmQRZycHr3nNuaRDpwD
	 3GmimTVYPHs9w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/2] NFSD: fix misaligned DIO READ to not use a start_extra_page, exposes rpcrdma bug?
Date: Sat, 30 Aug 2025 13:38:51 -0400
Message-ID: <20250830173852.26953-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250830173852.26953-1-snitzer@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Chuck Lever advised that allocating a single start_extra_page, to
avoid RDMA corruption on client, definitely shouldn't be needed:

    "There's nothing I can think of in the RDMA or RPC/RDMA protocols that
    mandates that the first page offset must always be zero. Moving data
    at one address on the server to an entirely different address and
    alignment on the client is exactly what RDMA is supposed to do.

    It sounds like an implementation omission because the server's upper
    layers have never needed it before now. If TCP already handles it, I'm
    guessing it's going to be straightforward to fix."

So avoid papering over what seems to be an rpcrdma bug, remove the
allocation and use of an extra start_extra_page.

With this patch applied ontop of v8 patchset [0], I get the following
data mismatch errors at the end [3] when using the NFS RDMA client
with reproducer documented in associated patch header since v2 [1]:

    "Must allocate and use a bounce-buffer page (called 'start_extra_page')
    if/when expanding the misaligned READ requires reading extra partial
    page at the start of the READ so that its DIO-aligned. Otherwise that
    extra page at the start will make its way back to the NFS client and
    corruption will occur. As found, and then this fix of using an extra
    page verified, using the 'dt' utility:
      dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
         iotype=sequential pattern=iot onerr=abort oncerr=abort
    see: https://github.com/RobinTMiller/dt.git "

I really did try to call attention to this misaligned DIO READ
alloc_page hack to make RDMA work, see [2], but I didn't frame it as
RDMA specific and definitely should've been clearer on that important
detail:

    "Also, I think its worth calling out this
    nfsd_complete_misaligned_read_dio function for its remapping/shifting
    of the READ payload reflected in rqstp->rq_bvec[]."

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

[0]: https://lore.kernel.org/linux-nfs/20250826185718.5593-1-snitzer@kernel.org/
[1]: https://lore.kernel.org/linux-nfs/20250708160619.64800-9-snitzer@kernel.org/
[2]: https://lore.kernel.org/linux-nfs/aG2MDVyyCbjTpgOv@kernel.org/
[3]: partial output of dt utility that shows NFS client READ data mismatch:
++ COUNT=3
++ IOSIZE=47008
++ dt of=/mnt/hs_test/dt_thisisa.test passes=1 bs=47008 count=3 iotype=sequential pattern=iot onerr=abort oncerr=abort
dt (j:1 t:1):
dt (j:1 t:1): Write Statistics:
dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
dt (j:1 t:1):       Last IOT seed value used: 0x01010101
dt (j:1 t:1):        Total records processed: 3 @ 47008 bytes/record (45.906 Kbytes)
dt (j:1 t:1):        Total bytes transferred: 141024 (137.719 Kbytes, 0.134 Mbytes)
dt (j:1 t:1):         Average transfer rates: 1004137 bytes/sec, 980.602 Kbytes/sec, 0.958 Mbytes/sec
dt (j:1 t:1):        Number I/O's per second: 21.361
dt (j:1 t:1):         Number seconds per I/O: 0.0468 (46.81ms)
dt (j:1 t:1):         Total passes completed: 0/1
dt (j:1 t:1):          Total errors detected: 0/1
dt (j:1 t:1):             Total elapsed time: 00m00.14s
dt (j:1 t:1):              Total system time: 00m00.00s
dt (j:1 t:1):                Total user time: 00m00.00s
dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1): Warning: The bytes written 141024, is less than the data limit 1880320000 requested!
dt (j:1 t:1): ERROR: Error number 1 occurred on Sat Aug 30 16:14:08 2025
dt (j:1 t:1):
dt (j:1 t:1):                   Error Number: 1
dt (j:1 t:1):          Time of Current Error: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):           Read Pass Start Time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):          Write Pass Start Time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):                    Pass Number: 1
dt (j:1 t:1):              Pass Elapsed Time: 00m00.10s
dt (j:1 t:1):              Test Elapsed Time: 00m00.24s
dt (j:1 t:1):                      File Name: /mnt/hs_test/dt_thisisa.test
dt (j:1 t:1):                     File Inode: 1199 (0x4af)
dt (j:1 t:1):                Directory Inode: 1 (0x1)
dt (j:1 t:1):                      File Size: 1880320000 (0x70136800)
dt (j:1 t:1):                      Operation: miscompare
dt (j:1 t:1):                  Record Number: 2
dt (j:1 t:1):                   Request Size: 47008 (0xb7a0)
dt (j:1 t:1):                   Block Length: 91 (0x5b)
dt (j:1 t:1):                       I/O Mode: read
dt (j:1 t:1):                       I/O Type: sequential
dt (j:1 t:1):                      File Type: output
dt (j:1 t:1):                     Direct I/O: disabled (caching data)
dt (j:1 t:1):                    Device Size: 512 (0x200)
dt (j:1 t:1):           Starting File Offset: 47008 (0xb7a0)
dt (j:1 t:1):                   Starting LBA: 91 (0x5b)
dt (j:1 t:1):             Ending File Offset: 94016 (0x16f40)
dt (j:1 t:1):                     Ending LBA: 182 (0xb6)
dt (j:1 t:1):              Error File Offset: 47008 (0xb7a0)
dt (j:1 t:1):           Error Offset Modulos: %8 = 0, %512 = 416, %4096 = 1952
dt (j:1 t:1):    Starting Relative Error LBA: 91 (0x5b)
dt (j:1 t:1):   Relative 4096 byte Error LBA: 11 (0xb)
dt (j:1 t:1):        Corruption Buffer Index: 0 (byte index into read buffer)
dt (j:1 t:1):         Corruption Block Index: 0 (byte index in miscompare block)
dt (j:1 t:1):
dt (j:1 t:1):
dt (j:1 t:1): Data compare error at byte 0 in record number 2
dt (j:1 t:1): Relative block number where the error occurred is 91, offset 47008
dt (j:1 t:1): Block expected = 91 (0x0000005b), block found = 1919311731 (0x72665f73), count = 47008
dt (j:1 t:1): The correct data starts at memory address 0x000000003c589000 (marked by asterisk '*')
dt (j:1 t:1): Dumping Pattern Buffer (base = 0x3c589000, mismatch offset = 0, limit = 512 bytes):
dt (j:1 t:1):                   / Buffer
dt (j:1 t:1):    Memory Address / Index
dt (j:1 t:1): 0x000000003c589000/     0 |*5b 00 00 00 5c 01 01 01 5d 02 02 02 5e 03 03 03 "[   \   ]   ^   "
dt (j:1 t:1): 0x000000003c589010/    16 | 5f 04 04 04 60 05 05 05 61 06 06 06 62 07 07 07 "_   `   a   b   "
dt (j:1 t:1): 0x000000003c589020/    32 | 63 08 08 08 64 09 09 09 65 0a 0a 0a 66 0b 0b 0b "c   d   e   f   "
dt (j:1 t:1): 0x000000003c589030/    48 | 67 0c 0c 0c 68 0d 0d 0d 69 0e 0e 0e 6a 0f 0f 0f "g   h   i   j   "
dt (j:1 t:1): 0x000000003c589040/    64 | 6b 10 10 10 6c 11 11 11 6d 12 12 12 6e 13 13 13 "k   l   m   n   "
dt (j:1 t:1): 0x000000003c589050/    80 | 6f 14 14 14 70 15 15 15 71 16 16 16 72 17 17 17 "o   p   q   r   "
dt (j:1 t:1): 0x000000003c589060/    96 | 73 18 18 18 74 19 19 19 75 1a 1a 1a 76 1b 1b 1b "s   t   u   v   "
dt (j:1 t:1): 0x000000003c589070/   112 | 77 1c 1c 1c 78 1d 1d 1d 79 1e 1e 1e 7a 1f 1f 1f "w   x   y   z   "
dt (j:1 t:1): 0x000000003c589080/   128 | 7b 20 20 20 7c 21 21 21 7d 22 22 22 7e 23 23 23 "{   |!!!}"""~###"
dt (j:1 t:1): 0x000000003c589090/   144 | 7f 24 24 24 80 25 25 25 81 26 26 26 82 27 27 27 " $$$ %%% &&& '''"
dt (j:1 t:1): 0x000000003c5890a0/   160 | 83 28 28 28 84 29 29 29 85 2a 2a 2a 86 2b 2b 2b " ((( ))) *** +++"
dt (j:1 t:1): 0x000000003c5890b0/   176 | 87 2c 2c 2c 88 2d 2d 2d 89 2e 2e 2e 8a 2f 2f 2f " ,,, --- ... ///"
dt (j:1 t:1): 0x000000003c5890c0/   192 | 8b 30 30 30 8c 31 31 31 8d 32 32 32 8e 33 33 33 " 000 111 222 333"
dt (j:1 t:1): 0x000000003c5890d0/   208 | 8f 34 34 34 90 35 35 35 91 36 36 36 92 37 37 37 " 444 555 666 777"
dt (j:1 t:1): 0x000000003c5890e0/   224 | 93 38 38 38 94 39 39 39 95 3a 3a 3a 96 3b 3b 3b " 888 999 ::: ;;;"
dt (j:1 t:1): 0x000000003c5890f0/   240 | 97 3c 3c 3c 98 3d 3d 3d 99 3e 3e 3e 9a 3f 3f 3f " <<< === >>> ???"
dt (j:1 t:1): 0x000000003c589100/   256 | 9b 40 40 40 9c 41 41 41 9d 42 42 42 9e 43 43 43 " @@@ AAA BBB CCC"
dt (j:1 t:1): 0x000000003c589110/   272 | 9f 44 44 44 a0 45 45 45 a1 46 46 46 a2 47 47 47 " DDD EEE FFF GGG"
dt (j:1 t:1): 0x000000003c589120/   288 | a3 48 48 48 a4 49 49 49 a5 4a 4a 4a a6 4b 4b 4b " HHH III JJJ KKK"
dt (j:1 t:1): 0x000000003c589130/   304 | a7 4c 4c 4c a8 4d 4d 4d a9 4e 4e 4e aa 4f 4f 4f " LLL MMM NNN OOO"
dt (j:1 t:1): 0x000000003c589140/   320 | ab 50 50 50 ac 51 51 51 ad 52 52 52 ae 53 53 53 " PPP QQQ RRR SSS"
dt (j:1 t:1): 0x000000003c589150/   336 | af 54 54 54 b0 55 55 55 b1 56 56 56 b2 57 57 57 " TTT UUU VVV WWW"
dt (j:1 t:1): 0x000000003c589160/   352 | b3 58 58 58 b4 59 59 59 b5 5a 5a 5a b6 5b 5b 5b " XXX YYY ZZZ [[["
dt (j:1 t:1): 0x000000003c589170/   368 | b7 5c 5c 5c b8 5d 5d 5d b9 5e 5e 5e ba 5f 5f 5f " \\\ ]]] ^^^ ___"
dt (j:1 t:1): 0x000000003c589180/   384 | bb 60 60 60 bc 61 61 61 bd 62 62 62 be 63 63 63 " ``` aaa bbb ccc"
dt (j:1 t:1): 0x000000003c589190/   400 | bf 64 64 64 c0 65 65 65 c1 66 66 66 c2 67 67 67 " ddd eee fff ggg"
dt (j:1 t:1): 0x000000003c5891a0/   416 | c3 68 68 68 c4 69 69 69 c5 6a 6a 6a c6 6b 6b 6b " hhh iii jjj kkk"
dt (j:1 t:1): 0x000000003c5891b0/   432 | c7 6c 6c 6c c8 6d 6d 6d c9 6e 6e 6e ca 6f 6f 6f " lll mmm nnn ooo"
dt (j:1 t:1): 0x000000003c5891c0/   448 | cb 70 70 70 cc 71 71 71 cd 72 72 72 ce 73 73 73 " ppp qqq rrr sss"
dt (j:1 t:1): 0x000000003c5891d0/   464 | cf 74 74 74 d0 75 75 75 d1 76 76 76 d2 77 77 77 " ttt uuu vvv www"
dt (j:1 t:1): 0x000000003c5891e0/   480 | d3 78 78 78 d4 79 79 79 d5 7a 7a 7a d6 7b 7b 7b " xxx yyy zzz {{{"
dt (j:1 t:1): 0x000000003c5891f0/   496 | d7 7c 7c 7c d8 7d 7d 7d d9 7e 7e 7e da 7f 7f 7f " ||| }}} ~~~    "
dt (j:1 t:1):
dt (j:1 t:1): The incorrect data starts at memory address 0x000000003c596000 (for Robin's debug! :)
dt (j:1 t:1): The incorrect data starts at file offset 000000000000047008 (marked by asterisk '*')
dt (j:1 t:1): Dumping Data File offsets (base = 47008, mismatch offset = 0, limit = 512 bytes):
dt (j:1 t:1):                   / Block
dt (j:1 t:1):       File Offset / Index
dt (j:1 t:1): 000000000000047008/     0 |*73 5f 66 72 65 65 5f 63 6f 6d 6d 69 74 5f 61 72 "s_free_commit_ar"
dt (j:1 t:1): 000000000000047024/    16 | 72 61 79 00 54 43 50 5f 54 49 4d 45 5f 57 41 49 "ray TCP_TIME_WAI"
dt (j:1 t:1): 000000000000047040/    32 | 54 00 42 50 46 5f 50 52 4f 47 5f 54 59 50 45 5f "T BPF_PROG_TYPE_"
dt (j:1 t:1): 000000000000047056/    48 | 43 47 52 4f 55 50 5f 53 59 53 43 54 4c 00 4c 41 "CGROUP_SYSCTL LA"
dt (j:1 t:1): 000000000000047072/    64 | 59 4f 55 54 5f 46 4c 45 58 5f 46 49 4c 45 53 00 "YOUT_FLEX_FILES "
dt (j:1 t:1): 000000000000047088/    80 | 4e 46 53 45 52 52 5f 4a 55 4b 45 42 4f 58 00 72 "NFSERR_JUKEBOX r"
dt (j:1 t:1): 000000000000047104/    96 | 78 5f 63 70 75 5f 72 6d 61 70 00 6d 69 67 72 61 "x_cpu_rmap migra"
dt (j:1 t:1): 000000000000047120/   112 | 74 69 6f 6e 5f 64 69 73 61 62 6c 65 64 00 5f 5f "tion_disabled __"
dt (j:1 t:1): 000000000000047136/   128 | 64 61 74 61 00 6e 64 6f 5f 64 65 6c 5f 73 6c 61 "data ndo_del_sla"
dt (j:1 t:1): 000000000000047152/   144 | 76 65 00 6e 66 73 5f 63 6f 6d 6d 69 74 5f 64 61 "ve nfs_commit_da"
dt (j:1 t:1): 000000000000047168/   160 | 74 61 00 65 78 74 5f 6d 75 74 65 78 00 63 6f 6e "ta ext_mutex con"
dt (j:1 t:1): 000000000000047184/   176 | 6e 65 63 74 5f 63 6f 6f 6b 69 65 00 54 43 50 5f "nect_cookie TCP_"
dt (j:1 t:1): 000000000000047200/   192 | 43 4c 4f 53 45 5f 57 41 49 54 00 6d 65 6d 63 6d "CLOSE_WAIT memcm"
dt (j:1 t:1): 000000000000047216/   208 | 70 00 52 50 4d 5f 52 45 51 5f 53 55 53 50 45 4e "p RPM_REQ_SUSPEN"
dt (j:1 t:1): 000000000000047232/   224 | 44 00 63 72 6d 61 74 63 68 00 63 61 6e 63 65 6c "D crmatch cancel"
dt (j:1 t:1): 000000000000047248/   240 | 5f 66 6f 72 6b 00 70 67 70 72 6f 74 5f 74 00 74 "_fork pgprot_t t"
dt (j:1 t:1): 000000000000047264/   256 | 72 61 63 65 70 6f 69 6e 74 5f 70 74 72 5f 74 00 "racepoint_ptr_t "
dt (j:1 t:1): 000000000000047280/   272 | 66 6f 72 5f 72 65 63 6c 61 69 6d 00 4e 46 53 45 "for_reclaim NFSE"
dt (j:1 t:1): 000000000000047296/   288 | 52 52 5f 42 41 44 43 48 41 52 00 5f 73 6b 62 5f "RR_BADCHAR _skb_"
dt (j:1 t:1): 000000000000047312/   304 | 72 65 66 64 73 74 00 70 68 79 73 69 63 61 6c 5f "refdst physical_"
dt (j:1 t:1): 000000000000047328/   320 | 6c 6f 63 61 74 69 6f 6e 00 6e 75 6d 5f 72 65 71 "location num_req"
dt (j:1 t:1): 000000000000047344/   336 | 73 00 5f 5f 53 43 54 5f 5f 74 70 5f 66 75 6e 63 "s __SCT__tp_func"
dt (j:1 t:1): 000000000000047360/   352 | 5f 70 6e 66 73 5f 6d 64 73 5f 66 61 6c 6c 62 61 "_pnfs_mds_fallba"
dt (j:1 t:1): 000000000000047376/   368 | 63 6b 5f 77 72 69 74 65 5f 64 6f 6e 65 00 74 61 "ck_write_done ta"
dt (j:1 t:1): 000000000000047392/   384 | 73 6b 5f 63 6c 65 61 6e 75 70 00 65 78 70 61 6e "sk_cleanup expan"
dt (j:1 t:1): 000000000000047408/   400 | 64 5f 72 65 61 64 61 68 65 61 64 00 6c 6f 63 6b "d_readahead lock"
dt (j:1 t:1): 000000000000047424/   416 | 5f 6d 61 6e 61 67 65 72 5f 6f 70 65 72 61 74 69 "_manager_operati"
dt (j:1 t:1): 000000000000047440/   432 | 6f 6e 73 00 73 72 63 5f 72 65 67 00 63 72 64 65 "ons src_reg crde"
dt (j:1 t:1): 000000000000047456/   448 | 73 74 72 6f 79 00 63 68 69 6c 64 72 65 6e 5f 6c "stroy children_l"
dt (j:1 t:1): 000000000000047472/   464 | 6f 77 5f 75 73 61 67 65 00 6e 75 6d 5f 76 66 00 "ow_usage num_vf "
dt (j:1 t:1): 000000000000047488/   480 | 73 63 72 61 74 63 68 00 50 49 44 54 59 50 45 5f "scratch PIDTYPE_"
dt (j:1 t:1): 000000000000047504/   496 | 4d 41 58 00 70 72 65 70 61 72 65 5f 77 72 69 74 "MAX prepare_writ"
dt (j:1 t:1):
dt (j:1 t:1):
dt (j:1 t:1): Analyzing IOT Record Data: (Note: Block #'s are relative to start of record!)
dt (j:1 t:1):
dt (j:1 t:1):                 IOT block size: 512
dt (j:1 t:1):         Total number of blocks: 91 (47008 bytes)
dt (j:1 t:1):         Current IOT seed value: 0x01010101 (pass 1)
dt (j:1 t:1):      Range of corrupted blocks: 0 - 90
dt (j:1 t:1):     Length of corrupted blocks: 91 (46592 bytes)
dt (j:1 t:1):   Corrupted blocks file offset: 47008 (LBA 91)
dt (j:1 t:1):     Number of corrupted blocks: 91
dt (j:1 t:1):    Number of good blocks found: 0
dt (j:1 t:1):    Number of zero blocks found: 0
dt (j:1 t:1):
dt (j:1 t:1):                       Record #: 2
dt (j:1 t:1):         Starting Record Offset: 47008
dt (j:1 t:1):                 Transfer Count: 47008 (0xb7a0)
dt (j:1 t:1):           Ending Record Offset: 94016
dt (j:1 t:1):    Relative Record Block Range: 91 - 182
dt (j:1 t:1):            Read Buffer Address: 0x3c596000
dt (j:1 t:1):           Pattern Base Address: 0x3c589000
dt (j:1 t:1):                           Note: Incorrect data is marked with asterisk '*'
dt (j:1 t:1):
dt (j:1 t:1):                   Record Block: 0 (BAD data)
dt (j:1 t:1):            Record Block Offset: 47008 (LBA 91)
dt (j:1 t:1):            Record Buffer Index: 0 (0x0)
dt (j:1 t:1):          Expected Block Number: 91 (0x0000005b)
dt (j:1 t:1):          Received Block Number: 1919311731 (0x72665f73)
dt (j:1 t:1):          Received Block Offset: 982687606272
dt (j:1 t:1):
dt (j:1 t:1): Byte Expected: address 0x3c589000          Received: address 0x3c596000
dt (j:1 t:1): 0000 0000005b 0101015c 0202025d 0303035e * 72665f73 635f6565 696d6d6f 72615f74
dt (j:1 t:1): 0010 0404045f 05050560 06060661 07070762 * 00796172 5f504354 454d4954 4941575f
dt (j:1 t:1): 0020 08080863 09090964 0a0a0a65 0b0b0b66 * 50420054 52505f46 545f474f 5f455059
dt (j:1 t:1): 0030 0c0c0c67 0d0d0d68 0e0e0e69 0f0f0f6a * 4f524743 535f5055 54435359 414c004c
dt (j:1 t:1): 0040 1010106b 1111116c 1212126d 1313136e * 54554f59 454c465f 49465f58 0053454c
dt (j:1 t:1): 0050 1414146f 15151570 16161671 17171772 * 4553464e 4a5f5252 42454b55 7200584f
dt (j:1 t:1): 0060 18181873 19191974 1a1a1a75 1b1b1b76 * 70635f78 6d725f75 6d007061 61726769
dt (j:1 t:1): 0070 1c1c1c77 1d1d1d78 1e1e1e79 1f1f1f7a * 6e6f6974 7369645f 656c6261 5f5f0064
dt (j:1 t:1): 0080 2020207b 2121217c 2222227d 2323237e * 61746164 6f646e00 6c65645f 616c735f
dt (j:1 t:1): 0090 2424247f 25252580 26262681 27272782 * 6e006576 635f7366 696d6d6f 61645f74
dt (j:1 t:1): 00a0 28282883 29292984 2a2a2a85 2b2b2b86 * 65006174 6d5f7478 78657475 6e6f6300
dt (j:1 t:1): 00b0 2c2c2c87 2d2d2d88 2e2e2e89 2f2f2f8a * 7463656e 6f6f635f 0065696b 5f504354
dt (j:1 t:1): 00c0 3030308b 3131318c 3232328d 3333338e * 534f4c43 41575f45 6d005449 6d636d65
dt (j:1 t:1): 00d0 3434348f 35353590 36363691 37373792 * 50520070 45525f4d 55535f51 4e455053
dt (j:1 t:1): 00e0 38383893 39393994 3a3a3a95 3b3b3b96 * 72630044 6374616d 61630068 6c65636e
dt (j:1 t:1): 00f0 3c3c3c97 3d3d3d98 3e3e3e99 3f3f3f9a * 726f665f 6770006b 746f7270 7400745f
dt (j:1 t:1): 0100 4040409b 4141419c 4242429d 4343439e * 65636172 6e696f70 74705f74 00745f72
dt (j:1 t:1): 0110 4444449f 454545a0 464646a1 474747a2 * 5f726f66 6c636572 006d6961 4553464e
dt (j:1 t:1): 0120 484848a3 494949a4 4a4a4aa5 4b4b4ba6 * 425f5252 48434441 5f005241 5f626b73
dt (j:1 t:1): 0130 4c4c4ca7 4d4d4da8 4e4e4ea9 4f4f4faa * 64666572 70007473 69737968 5f6c6163
dt (j:1 t:1): 0140 505050ab 515151ac 525252ad 535353ae * 61636f6c 6e6f6974 6d756e00 7165725f
dt (j:1 t:1): 0150 545454af 555555b0 565656b1 575757b2 * 5f5f0073 5f544353 5f70745f 636e7566
dt (j:1 t:1): 0160 585858b3 595959b4 5a5a5ab5 5b5b5bb6 * 666e705f 646d5f73 61665f73 61626c6c
dt (j:1 t:1): 0170 5c5c5cb7 5d5d5db8 5e5e5eb9 5f5f5fba * 775f6b63 65746972 6e6f645f 61740065
dt (j:1 t:1): 0180 606060bb 616161bc 626262bd 636363be * 635f6b73 6e61656c 65007075 6e617078
dt (j:1 t:1): 0190 646464bf 656565c0 666666c1 676767c2 * 65725f64 68616461 00646165 6b636f6c
dt (j:1 t:1): 01a0 686868c3 696969c4 6a6a6ac5 6b6b6bc6 * 6e616d5f 72656761 65706f5f 69746172
dt (j:1 t:1): 01b0 6c6c6cc7 6d6d6dc8 6e6e6ec9 6f6f6fca * 00736e6f 5f637273 00676572 65647263
dt (j:1 t:1): 01c0 707070cb 717171cc 727272cd 737373ce * 6f727473 68630079 72646c69 6c5f6e65
dt (j:1 t:1): 01d0 747474cf 757575d0 767676d1 777777d2 * 755f776f 65676173 6d756e00 0066765f
dt (j:1 t:1): 01e0 787878d3 797979d4 7a7a7ad5 7b7b7bd6 * 61726373 00686374 54444950 5f455059
dt (j:1 t:1): 01f0 7c7c7cd7 7d7d7dd8 7e7e7ed9 7f7f7fda * 0058414d 70657270 5f657261 74697277
...
dt (j:1 t:1): Reread data does NOT match previous data or expected data!
dt (j:1 t:1): Writing reread data to file dt_thisisa.test-REREAD3-j1t1, from buffer 0x7f12bc004000, 47008 bytes...
dt (j:1 t:1): Command line to re-read the corrupted data:
dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 count=1 offset=47008 pattern=iot disable=retryDC,savecorrupted,trigdefaults
dt (j:1 t:1):
dt (j:1 t:1): Command line to re-read the data:
dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 dsize=512 iotype=sequential iodir=forward limit=94016 records=1 pattern=iot disable=retryDC,savecorrupted,trigdefaults
dt (j:1 t:1):
dt (j:1 t:1):
dt (j:1 t:1): Read Statistics:
dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
dt (j:1 t:1):       Last IOT seed value used: 0x01010101
dt (j:1 t:1):        Total records processed: 2 @ 47008 bytes/record (45.906 Kbytes)
dt (j:1 t:1):        Total bytes transferred: 94016 (91.812 Kbytes, 0.090 Mbytes)
dt (j:1 t:1):         Average transfer rates: 656857 bytes/sec, 641.462 Kbytes/sec, 0.626 Mbytes/sec
dt (j:1 t:1):        Number I/O's per second: 13.973
dt (j:1 t:1):         Number seconds per I/O: 0.0716 (71.56ms)
dt (j:1 t:1):         Total passes completed: 1/1
dt (j:1 t:1):          Total errors detected: 1/1
dt (j:1 t:1):             Total elapsed time: 00m00.15s
dt (j:1 t:1):              Total system time: 00m00.00s
dt (j:1 t:1):                Total user time: 00m00.00s
dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):
dt (j:1 t:1): Operating System Information:
dt (j:1 t:1):                      Host name: plsm121c-06.perf.hammer.space (192.168.1.106)
dt (j:1 t:1):                      User name: root
dt (j:1 t:1):                     Process ID: 31703
dt (j:1 t:1):                 OS information: Linux 6.12.24.17.hs.snitm+ #34 SMP PREEMPT_DYNAMIC Fri Aug 15 22:03:10 UTC 2025 x86_64
dt (j:1 t:1):
dt (j:1 t:1): File System Information:
dt (j:1 t:1):            Mounted from device: 192.168.0.105:/hs_test
dt (j:1 t:1):           Mounted on directory: /mnt/hs_test
dt (j:1 t:1):                Filesystem type: nfs4
dt (j:1 t:1):             Filesystem options: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,fatal_neterrors=none,proto=tcp,nconnect=16,port=20491,timeo=600,retrans=2,sec=sys,clientaddr=192.168.0.106,local_lock=none,addr=192.168.0.105
dt (j:1 t:1):          Filesystem block size: 1048576
dt (j:1 t:1):          Filesystem free space: 60990430380032 (58165007.000 Mbytes, 56801.765 Gbytes, 55.470 Tbytes)
dt (j:1 t:1):         Filesystem total space: 60992310476800 (58166800.000 Mbytes, 56803.516 Gbytes, 55.472 Tbytes)
dt (j:1 t:1):
dt (j:1 t:1): Total Statistics:
dt (j:1 t:1):        Output device/file name: /mnt/hs_test/dt_thisisa.test (device type=regular)
dt (j:1 t:1):        Type of I/O's performed: sequential (forward)
dt (j:1 t:1):       Job Information Reported: Job 1, Thread 1
dt (j:1 t:1):       Data pattern string used: 'IOT Pattern' (blocking is 512 bytes)
dt (j:1 t:1):       Last IOT seed value used: 0x01010101
dt (j:1 t:1):             Total records read: 2
dt (j:1 t:1):               Total bytes read: 94016 (91.812 Kbytes, 0.090 Mbytes, 0.000 Gbytes)
dt (j:1 t:1):          Total records written: 3
dt (j:1 t:1):            Total bytes written: 141024 (137.719 Kbytes, 0.134 Mbytes, 0.000 Gbytes)
dt (j:1 t:1):        Total records processed: 5 @ 47008 bytes/record (45.906 Kbytes)
dt (j:1 t:1):        Total bytes transferred: 235040 (229.531 Kbytes, 0.224 Mbytes)
dt (j:1 t:1):         Average transfer rates: 828023 bytes/sec, 808.616 Kbytes/sec, 0.790 Mbytes/sec
dt (j:1 t:1):        Number I/O's per second: 17.615
dt (j:1 t:1):         Number seconds per I/O: 0.0568 (56.77ms)
dt (j:1 t:1):         Total passes completed: 1/1
dt (j:1 t:1):          Total errors detected: 1/1
dt (j:1 t:1):             Total elapsed time: 00m00.29s
dt (j:1 t:1):              Total system time: 00m00.00s
dt (j:1 t:1):                Total user time: 00m00.00s
dt (j:1 t:1):                  Starting time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):                    Ending time: Sat Aug 30 16:14:08 2025
dt (j:1 t:1):
dt (j:1 t:1): Command line to re-read the data:
dt (j:1 t:1):     # dt if=/mnt/hs_test/dt_thisisa.test bs=47008 dsize=512 iotype=sequential iodir=forward limit=141024 records=3 pattern=iot
dt (j:1 t:1):
dt (j:1 t:1): Command Line:
dt (j:1 t:1):
dt (j:1 t:1):     # dt of=/mnt/hs_test/dt_thisisa.test passes=1 bs=47008 count=3 iotype=sequential pattern=iot onerr=abort oncerr=abort
dt (j:1 t:1):
dt (j:1 t:1):         --> Date: September 21st, 2023, Version: 25.05, Author: Robin T. Miller <--
dt (j:1 t:1):
dt (j:1 t:1): onerr=abort, so stopping all threads for job 1...
dt (j:0 t:0): Job 1 is being stopped (1 thread)
dt (j:0 t:0): Program is exiting with status -1...
---
 fs/nfsd/vfs.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f8975ee262b5c..762d745b1b15d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1079,13 +1079,11 @@ struct nfsd_read_dio {
 	loff_t end;
 	unsigned long start_extra;
 	unsigned long end_extra;
-	struct page *start_extra_page;
 };
 
 static void init_nfsd_read_dio(struct nfsd_read_dio *read_dio)
 {
 	memset(read_dio, 0, sizeof(*read_dio));
-	read_dio->start_extra_page = NULL;
 }
 
 #define NFSD_READ_DIO_MIN_KB (32 << 10)
@@ -1121,9 +1119,8 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/*
 	 * Any misaligned READ less than NFSD_READ_DIO_MIN_KB won't be expanded
-	 * to be DIO-aligned (this heuristic avoids excess work, like allocating
-	 * start_extra_page, for smaller IO that can generally already perform
-	 * well using buffered IO).
+	 * to be DIO-aligned (this heuristic avoids excess work, for smaller IO
+	 * that can generally already perform well using buffered IO).
 	 */
 	if ((read_dio->start_extra || read_dio->end_extra) &&
 	    (len < NFSD_READ_DIO_MIN_KB)) {
@@ -1131,15 +1128,6 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return false;
 	}
 
-	if (read_dio->start_extra) {
-		read_dio->start_extra_page = alloc_page(GFP_KERNEL);
-		if (WARN_ONCE(read_dio->start_extra_page == NULL,
-			      "%s: Unable to allocate start_extra_page\n", __func__)) {
-			init_nfsd_read_dio(read_dio);
-			return false;
-		}
-	}
-
 	/* Show original offset and count, and how it was expanded for DIO */
 	middle_end = read_dio->end - read_dio->end_extra;
 	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
@@ -1162,11 +1150,10 @@ static ssize_t nfsd_complete_misaligned_read_dio(struct svc_rqst *rqstp,
 	if (!read_dio->start_extra && !read_dio->end_extra)
 		return host_err;
 
-	/* If nfsd_analyze_read_dio() allocated a start_extra_page it must
-	 * be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
+	/* If nfsd_analyze_read_dio() found start_extra (front-pad) page needed it
+	 * must be removed from rqstp->rq_bvec[] to avoid returning unwanted data.
 	 */
-	if (read_dio->start_extra_page) {
-		__free_page(read_dio->start_extra_page);
+	if (read_dio->start_extra) {
 		*rq_bvec_numpages -= 1;
 		v = *rq_bvec_numpages;
 		memmove(rqstp->rq_bvec, rqstp->rq_bvec + 1,
@@ -1276,7 +1263,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			if (read_dio.start_extra) {
 				len = read_dio.start_extra;
 				bvec_set_page(&rqstp->rq_bvec[v],
-					      read_dio.start_extra_page,
+					      *(rqstp->rq_next_page++),
 					      len, PAGE_SIZE - len);
 				total -= len;
 				++v;
-- 
2.44.0


