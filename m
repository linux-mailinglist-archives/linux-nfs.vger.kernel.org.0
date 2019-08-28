Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E29FFAA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfH1KXG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 06:23:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42481 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1KXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 06:23:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so1214209pgb.9
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=y+6igPgMIOyoIHEbzJrg3oky+cnOgXxy3jd54a5jvgU=;
        b=u68L0TXOAgky8gA2yr1KzuDfZ6G61fi4/pqs4GaUGADVcxs5FqqNFpEfT58f57nwxB
         oYBxiMc1dh/cCoUiiU8bB7zDhN75M7AtmhCTD5yWQ4rqnZ1KXVCCI2+WGmhAFKktgf3p
         ZS52juf8fGCKMxKYjI2VBtH+YJo8cpP3nQEEmM0GhO6rh5hrL9Q7s74IeduSyoaVf0ts
         b3arUwtjv+WaE5/mSVKFrOxMKeyuGMDbcbtWLUHxObl2/CjCZwFU02PDB+nJB7G3n0uK
         QzHbwULavNhB0eq///YHRO+RbFII2Zjjx8pV56FhBxDvwyygW+ukNm9TEN1Mp7R77e2L
         13wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=y+6igPgMIOyoIHEbzJrg3oky+cnOgXxy3jd54a5jvgU=;
        b=ZVkZshnya+VKZmTd4Nud8gQOZVS6Szrv+0fKp+WUUZU4MvRcsNFJ8F7DAgLGw08Amf
         MLGCTo0Z9yF9L7cGKAt5EGy7lRyYQBs4VTiDaq55UMww+UdES2hH8gAMMxLXhy8Dy3HG
         0nGGfNGFhSKUxz0vh/r4XKaR3HC8nJUcHEeQVt6wvTLcfd2uz0QE1Oo6lzofo954Q8en
         ngKeWdp2uy0rK/8LcEl2MmlaMMUrvSWwJZNBtFv/iGiVzawKhfbZE2o/qpfCRXG0oFsB
         Xycv5An3EJf/sK9MVUt1Kcl3jOFa9uhIQ81QVzAcSycBHi+aFV18vnYb7nP/Ji3ADiEs
         X1jA==
X-Gm-Message-State: APjAAAXDXkwShoL20ONBcpQ5UGBAHmOYPV2fqq4/Z73gA6lETAC6kFT0
        8NfDJ4wQtNCkKlaJaZoiXptwwkgT
X-Google-Smtp-Source: APXvYqxSv/JRFoj1P1lsXV6gxmiwPuy5FDYyVeWT5lhBH+wXvYoKGL8mFpV7USfSuKOXESX//wAn5g==
X-Received: by 2002:a17:90a:24ed:: with SMTP id i100mr3476839pje.47.1566987784844;
        Wed, 28 Aug 2019 03:23:04 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b126sm3857167pfa.177.2019.08.28.03.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 03:23:04 -0700 (PDT)
Date:   Wed, 28 Aug 2019 18:22:56 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     ltp@lists.linux.it
Subject: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Message-ID: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gkp6ragylzfkgwea"
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--gkp6ragylzfkgwea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

If write to file with O_DIRECT, then read it without O_DIRECT, read returns 0.
From tshark output, looks like the READ call is missing.

LTP[1] dio tests spot this. Things work well before this update.

Bisect log is pointing to:

	commit 7e10cc25bfa0dd3602bbcf5cc9c759a90eb675dc
	Author: Trond Myklebust <trond.myklebust@hammerspace.com>
	Date:   Fri Aug 9 12:06:43 2019 -0400
	
	    NFS: Don't refresh attributes with mounted-on-file informatio

With this commit reverted, the tests pass again.

It's only about NFSv4(4.0 4.1 and 4.2), NFSv3 works well.

Bisect log, outputs of tshark, sample test programme derived from
LTP diotest02.c and a simple test script are attached.

If this is an expected change, we will need to update the testcases.

Thanks,
Murphy

[1] https://github.com/linux-test-project/ltp.git

--gkp6ragylzfkgwea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dio02.c"

/*
 * LTP diotest02.c alt
*/
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/file.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <errno.h>

#define	BUFSIZE	4096
#define LEN	30

char filename[LEN];
int bufsize = BUFSIZE;

void fillbuf(char *buf, int count, char value)
{
	while (count > 0) {
		strncpy(buf, &value, 1);
		buf++;
		count = count - 1;
	}
}

/*
 * bufcmp: Compare two buffers
 * vbufcmp: Compare two buffers of two io arrays
*/
int bufcmp(char *b1, char *b2, int bsize)
{
	int i;

	for (i = 0; i < bsize; i++) {
		if (strncmp(&b1[i], &b2[i], 1)) {
			fprintf(stderr,
				"bufcmp: offset %d: Expected: 0x%x, got 0x%x\n",
				i, b1[i], b2[i]);
			return (-1);
		}
	}
	return (0);
}

/*
 * runtest: write the data to the file. Read the data from the file and compare.
*/
int runtest(int fd_r, int fd_w)
{
	char *buf1;
	char *buf2;
	int i = 0, ret;

	/* Allocate for buffers */
	if ((buf1 = valloc(bufsize)) == 0) {
		printf("valloc() buf1 failed: %s\n", strerror(errno));
		return (-1);
	}
	if ((buf2 = valloc(bufsize)) == 0) {
		printf("valloc() buf2 failed: %s\n", strerror(errno));
		return (-1);
	}

	fillbuf(buf1, bufsize, i);
#if 0
	if (lseek(fd_w, i * bufsize, SEEK_SET) < 0) {
		printf("lseek before write failed: %s\n", strerror(errno));
		return (-1);
	}
#endif
	ret = write(fd_w, buf1, bufsize);
	if (ret < bufsize) {
		printf("%d write failed: %s\n", ret, strerror(errno));
		return (-1);
	}
#if 0
	if (lseek(fd_r, i * bufsize, SEEK_SET) < 0) {
		printf("lseek before read failed: %s", strerror(errno));
		return (-1);
	}
#endif
	ret = read(fd_r, buf2, bufsize);
	if (ret < bufsize) {
		printf("i %d ret %d read failed: %s\n", i, ret, strerror(errno));
		return (-1);
	}
	if (bufcmp(buf1, buf2, bufsize) != 0) {
		printf("read/write comparision failed");
		return (-1);
	}
}

int main(int argc, char *argv[])
{
	long offset = 0;	/* Offset. Default 0 */
	int i, fd_r, fd_w;

	/* Options */
	sprintf(filename, "testdata-2.%ld", syscall(__NR_gettid));
#if 0
	/* Testblock-1: Read with Direct IO, Write without */
	if ((fd_w = open(filename, O_WRONLY | O_CREAT, 0666)) < 0)
		printf("open(%s, O_WRONLY..) failed\n", filename);
	if ((fd_r = open(filename, O_DIRECT | O_RDONLY, 0666)) < 0)
		printf("open(%s, O_DIRECT|O_RDONLY..) failed\n", filename);
	if (runtest(fd_r, fd_w) < 0) {
		printf("Read with Direct IO, Write without. FAIL\n");
	} else
		printf("Read with Direct IO, Write without. PASS\n");
	close(fd_w);
	close(fd_r);
	unlink(filename);
#endif
	/* Testblock-2: Write with Direct IO, Read without */
	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) == -1)
		printf(
			 "open(%s, O_DIRECT|O_WRONLY..) failed\n", filename);
	if ((fd_r = open(filename, O_RDONLY | O_CREAT, 0666)) == -1)
		printf(
			 "open(%s, O_RDONLY..) failed\n", filename);
	if (runtest(fd_r, fd_w) < 0) {
		printf("Write with Direct IO, Read without. FAIL\n");
	} else
		printf("Write with Direct IO, Read without. PASS\n");
	close(fd_w);
	close(fd_r);
	unlink(filename);
#if 0
	/* Testblock-3: Read, Write with Direct IO. */
	if ((fd_w = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666)) == -1)
		printf(
			 "open(%s, O_DIRECT|O_WRONLY|O_CREAT, ..) failed\n",
			 filename);
	if ((fd_r = open(filename, O_DIRECT | O_RDONLY | O_CREAT, 0666)) == -1)
		printf(
			 "open(%s, O_DIRECT|O_RDONLY|O_CREAT, ..) failed\n",
			 filename);
	if (runtest(fd_r, fd_w) < 0) {
		printf("Read, Write with Direct IO. FAIL\n");
	} else
		printf("Read, Write with Direct IO. PASS\n");
	close(fd_w);
	close(fd_r);
	unlink(filename);
#endif
}

--gkp6ragylzfkgwea
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0Amkdir -p /nfsexport /nfsmnt=0Acp /etc/exports{,.backup}=0Aech=
o "/nfsexport *(rw,no_root_squash)" > /etc/exports=0Asystemctl restart nfs-=
server=0Asleep 90=0Aumount /nfsmnt=0Amount -t nfs -o vers=3D4.2 localhost:/=
nfsexport /nfsmnt || exit=0Acd /nfsmnt=0Acp /root/dio02.c .=0Acc dio02.c=0A=
tcpdump -U -s 9000 -i lo -w /root/dump.out.$$ port 2049 &=0Asleep 1=0A ./a.=
out=0Asleep 1=0Akill -2 $!=0Acd=0Aumount /nfsmnt=0A
--gkp6ragylzfkgwea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fail.tshark"

1 0 ::1 -> ::1 NFS 338 V4 Call OPEN DH: 0xcaa30fbb/
2 0 ::1 -> ::1 NFS 442 V4 Reply (Call In 1) OPEN StateID: 0xdea3
3 0 ::1 -> ::1 TCP 86 976 > nfs [ACK] Seq=253 Ack=357 Win=510 Len=0 TSval=1580593188 TSecr=1580593188
4 0 ::1 -> ::1 NFS 286 V4 Call READ StateID: 0xfec3 Offset: 0 Len: 13320
5 0 ::1 -> ::1 NFS 13514 V4 Reply (Call In 4)[Packet size limited during capture]
6 0 ::1 -> ::1 TCP 86 976 > nfs [ACK] Seq=453 Ack=13785 Win=455 Len=0 TSval=1580593189 TSecr=1580593189
7 0 ::1 -> ::1 NFS 262 V4 Call ACCESS FH: 0xcaa30fbb, [Check: RD MD XT XE]
8 0 ::1 -> ::1 NFS 194 V4 Reply (Call In 7) ACCESS, [Allowed: RD MD XT XE]
9 0 ::1 -> ::1 TCP 86 976 > nfs [ACK] Seq=629 Ack=13893 Win=512 Len=0 TSval=1580593190 TSecr=1580593190
10 0 ::1 -> ::1 NFS 382 V4 Call[Malformed Packet]
11 0 ::1 -> ::1 TCP 86 nfs > 976 [ACK] Seq=13893 Ack=925 Win=512 Len=0 TSval=1580593233 TSecr=1580593192
12 0 ::1 -> ::1 NFS 470 V4 Reply (Call In 10) OPEN StateID: 0xe7d5 | LOCKT
13 0 ::1 -> ::1 TCP 86 976 > nfs [ACK] Seq=925 Ack=14277 Win=509 Len=0 TSval=1580593252 TSecr=1580593252
14 0 ::1 -> ::1 NFS 338 V4 Call OPEN DH: 0x1dfcdd98/
15 0 ::1 -> ::1 TCP 86 nfs > 976 [ACK] Seq=14277 Ack=1177 Win=512 Len=0 TSval=1580593253 TSecr=1580593253
16 0 ::1 -> ::1 NFS 406 V4 Reply (Call In 14) OPEN StateID: 0xe922
17 0 ::1 -> ::1 NFS 4386 V4 Call WRITE StateID: 0xe278 Offset: 0 Len: 4096
18 0 ::1 -> ::1 TCP 86 nfs > 976 [ACK] Seq=14597 Ack=5477 Win=512 Len=0 TSval=1580593254 TSecr=1580593254
19 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 17) WRITE
20 0 ::1 -> ::1 NFS 286 V4 Call OPEN_DOWNGRADE
21 0 ::1 -> ::1 TCP 86 nfs > 976 [ACK] Seq=14713 Ack=5677 Win=512 Len=0 TSval=1580593303 TSecr=1580593302
22 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 20) OPEN_DOWNGRADE
23 0 ::1 -> ::1 NFS 294 V4 Call CLOSE StateID: 0xec8f
24 0 ::1 -> ::1 TCP 86 nfs > 976 [ACK] Seq=14829 Ack=5885 Win=512 Len=0 TSval=1580593304 TSecr=1580593304
25 0 ::1 -> ::1 NFS 266 V4 Reply (Call In 23) CLOSE
26 0 ::1 -> ::1 NFS 266 V4 Call REMOVE DH: 0x72fff125/testdata-2.3006
27 0 ::1 -> ::1 NFS 206 V4 Reply (Call In 26) REMOVE
28 0 ::1 -> ::1 NFS 278 V4 Call CLOSE StateID: 0xdea3
29 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 28) CLOSE
30 0 ::1 -> ::1 TCP 86 976 > nfs [ACK] Seq=6257 Ack=15245 Win=512 Len=0 TSval=1580593374 TSecr=1580593333

--gkp6ragylzfkgwea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pass.tshark"

1 0 ::1 -> ::1 NFS 338 V4 Call OPEN DH: 0x9dd44c93/
2 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=1 Ack=253 Win=511 Len=0 TSval=2084813185 TSecr=2084813185
3 0 ::1 -> ::1 NFS 442 V4 Reply (Call In 1) OPEN StateID: 0x23a1
4 0 ::1 -> ::1 TCP 86 984 > nfs [ACK] Seq=253 Ack=357 Win=510 Len=0 TSval=2084813185 TSecr=2084813185
5 0 ::1 -> ::1 NFS 286 V4 Call READ StateID: 0x03c1 Offset: 0 Len: 13320
6 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=357 Ack=453 Win=512 Len=0 TSval=2084813186 TSecr=2084813186
7 0 ::1 -> ::1 NFS 13514 V4 Reply (Call In 5)[Packet size limited during capture]
8 0 ::1 -> ::1 TCP 86 984 > nfs [ACK] Seq=453 Ack=13785 Win=455 Len=0 TSval=2084813186 TSecr=2084813186
9 0 ::1 -> ::1 NFS 262 V4 Call ACCESS FH: 0x9dd44c93, [Check: RD MD XT XE]
10 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=13785 Ack=629 Win=512 Len=0 TSval=2084813187 TSecr=2084813187
11 0 ::1 -> ::1 NFS 194 V4 Reply (Call In 9) ACCESS, [Allowed: RD MD XT XE]
12 0 ::1 -> ::1 TCP 86 984 > nfs [ACK] Seq=629 Ack=13893 Win=512 Len=0 TSval=2084813187 TSecr=2084813187
13 0 ::1 -> ::1 NFS 382 V4 Call[Malformed Packet]
14 0 ::1 -> ::1 NFS 470 V4 Reply (Call In 13) OPEN StateID: 0x1ad7 | LOCKT
15 0 ::1 -> ::1 NFS 338 V4 Call OPEN DH: 0x2685228d/
16 0 ::1 -> ::1 NFS 406 V4 Reply (Call In 15) OPEN StateID: 0x1420
17 0 ::1 -> ::1 NFS 4386 V4 Call WRITE StateID: 0x1f7a Offset: 0 Len: 4096
18 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=14597 Ack=5477 Win=512 Len=0 TSval=2084813269 TSecr=2084813229
19 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 17) WRITE
20 0 ::1 -> ::1 NFS 286 V4 Call READ StateID: 0x1f7a Offset: 0 Len: 4096
21 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=14713 Ack=5677 Win=512 Len=0 TSval=2084813299 TSecr=2084813299
22 0 ::1 -> ::1 NFS 4290 V4 Reply (Call In 20) READ
23 0 ::1 -> ::1 NFS 286 V4 Call OPEN_DOWNGRADE
24 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=18917 Ack=5877 Win=512 Len=0 TSval=2084813300 TSecr=2084813300
25 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 23) OPEN_DOWNGRADE
26 0 ::1 -> ::1 NFS 294 V4 Call CLOSE StateID: 0x118d
27 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=19033 Ack=6085 Win=512 Len=0 TSval=2084813301 TSecr=2084813301
28 0 ::1 -> ::1 NFS 266 V4 Reply (Call In 26) CLOSE
29 0 ::1 -> ::1 NFS 266 V4 Call REMOVE DH: 0x8f59bce9/testdata-2.2547
30 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=19213 Ack=6265 Win=512 Len=0 TSval=2084813302 TSecr=2084813301
31 0 ::1 -> ::1 NFS 206 V4 Reply (Call In 29) REMOVE
32 0 ::1 -> ::1 NFS 278 V4 Call CLOSE StateID: 0x23a1
33 0 ::1 -> ::1 TCP 86 nfs > 984 [ACK] Seq=19333 Ack=6457 Win=512 Len=0 TSval=2084813324 TSecr=2084813324
34 0 ::1 -> ::1 NFS 202 V4 Reply (Call In 32) CLOSE
35 0 ::1 -> ::1 TCP 86 984 > nfs [ACK] Seq=6457 Ack=19449 Win=512 Len=0 TSval=2084813365 TSecr=2084813324

--gkp6ragylzfkgwea--
