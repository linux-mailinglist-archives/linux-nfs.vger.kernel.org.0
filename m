Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F035C2ACE79
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 05:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJESx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJESx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 23:18:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8CC0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 20:18:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f38so9062085pgm.2
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 20:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v1Sc4PjPGpot7NoATWAYOOjbPzYoqv7HnG/nSNu682I=;
        b=Qjbs99cu8XA02OyTHfK9fsD4JPargyw6WgNGJKhdoiQ4wsrtyrityQN/k18cNolY9I
         BGcCefSI0zfrZ/Hqm2PpE9IjLjttmNEA2EGEMx/qU/yCraN2eYz+H5s3Buz8AlEiVq9d
         ut2L3wNA6c4mCOdYy08ojT633EV0NaZo5x7IKDCR1rPmaSOHb/NGgxwYkjOh4gsO2DpO
         Yqk25HXPzo/OXnNYabAcA2DUpXujA00uHdl5frk73olk6SZ6y2Iop8CmUQWYFeaGItcv
         PCKPQibO1cVlPcc7F306Vh5BDObwrnX/yBRbu5V7s7e04PzqKl209Z5/QhbsAKVTSlDF
         3KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v1Sc4PjPGpot7NoATWAYOOjbPzYoqv7HnG/nSNu682I=;
        b=YiTIwNl2jQsXlr4I+9bQkDhV+CQgwXw9oXkU2EmEqo5E78+mHtY5P6u8a2Y9JWBfNY
         AGuhI3Uvkkp5+A2zsZnghRNwXt2aV4OZO45X1x2073b7F+yu5UVNZlT+g74AXUKWtZOe
         mjWmy58kfdpHooBzGR51PMV+sJsNA7wGYMn9j0RuHPE5yQfOzfSRanOmKl9jv+g++nND
         7plBu2sUrJ4/AFAEouyWXFIRP7YS7wBgs045niQPw2CphP4SEEOLU5WhP7ydHBUZchnD
         V8PYkSo1jP1l/9qDzI9QQJatV7xvfCddxdNmG5MxWoLQ9J9++bzTnth8eT8kBBVPO5a5
         9mgw==
X-Gm-Message-State: AOAM533gWDWalC6LXMDfBTwfOd2ZBwSvF9qwMoHap1Ocs3j6eg45DJx7
        ANqwWn4kVllnSBUtgr0QgCRmUqqBP9s=
X-Google-Smtp-Source: ABdhPJwgFUXV6tHp6FhiYwxg79EG+2kSQj28G/zUt5kKPsjh/q9zQZWJpV1wGGYCSxOgTS7VBGe7FA==
X-Received: by 2002:a63:fc5f:: with SMTP id r31mr15344590pgk.90.1604981932899;
        Mon, 09 Nov 2020 20:18:52 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k17sm1118543pji.50.2020.11.09.20.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:18:52 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:18:45 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     linux-nfs@vger.kernel.org, ltp@lists.linux.it
Subject: Last NFSD update breaks nfsv4.2 copy_file_range
Message-ID: <20201110041845.ag2kj3l6l6263ri5@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gntlxg3aq5x7mobf"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--gntlxg3aq5x7mobf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

copy_file_range for NFSv4.2 is broke by this

commit 9f0b5792f07d8f0745c3620d577d6930ff2a96fd
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Mon Sep 28 13:09:01 2020 -0400

    NFSD: Encode a full READ_PLUS reply


LTP copy_file_range01 repeats this failure:
copy_file_range01.c:144: TFAIL: file contents do not match

Revert this commit then the failure gone.

Attached simplified reproducer for your ref.

-- 
Murphy

--gntlxg3aq5x7mobf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="copy_file_range.c"

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	int fd_in, fd_out;
	struct stat stat;
	loff_t len;
	ssize_t ret;
	char buf[2];
	loff_t in = 0, out, i2, o2, to_cp, copied;

	if (argc != 6) {
		fprintf(stderr, "Usage: %s <src> <dest> inoff outoff len\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	fd_in = open(argv[1], O_RDONLY);
	if (fd_in == -1) {
		perror("open (argv[1])");
		exit(EXIT_FAILURE);
	}

	fd_out = open(argv[2], O_CREAT|O_WRONLY|O_TRUNC|O_SYNC, 0644);
	if (fd_out == -1) {
		perror("open (argv[2])");
		exit(EXIT_FAILURE);
	}

	in = strtoul(argv[3], NULL, 0);
	out = strtoul(argv[4], NULL, 0);
	len = strtoul(argv[5], NULL, 0);
	i2 = in;
	o2 = out;
	to_cp = len;

	do {
		ret = copy_file_range(fd_in, &in, fd_out, &out, to_cp, 0);
		if (ret == -1) {
			perror("copy_file_range");
			exit(EXIT_FAILURE);
		}
		copied += ret;
		to_cp -= ret;
	} while (to_cp > 0 && ret > 0);

	close(fd_in);
	close(fd_out);
	sync();

	FILE *fp1, *fp2;
	int ch1, ch2, count = 0;

	fp1 = fopen(argv[1], "r");
	if (fseek(fp1, i2, SEEK_SET)) {
		perror("fseek fp1");
		exit(EXIT_FAILURE);
	}
	fp2 = fopen(argv[2], "r");
	if (fseek(fp2, o2, SEEK_SET)) {
		perror("fseek fp2");
		exit(EXIT_FAILURE);
	}

	do {
		ch1 = fgetc(fp1);
		ch2 = fgetc(fp2);
		count++;
	} while ((count < len) && (ch1 == ch2));
	fclose(fp1);
	fclose(fp2);

	if (ch1 != ch2) {
		printf("%d %d %d copied %d ch1 %c ch2 %c count %d file content corrupted\n", i2, o2, len, copied, ch1, ch2, count);
		return 1;
	}
	return 0;
}

--gntlxg3aq5x7mobf
Content-Type: application/x-sh
Content-Disposition: attachment; filename="nfs_copy_range.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0Amkdir -p /nfsexport /nfsmnt=0Acp /etc/exports{,.back}=0Acat >=
 /etc/exports <<EOF=0A/nfsexport *(rw,no_root_squash)=0AEOF=0Asystemctl res=
tart nfs-server || exit=0Acc copy_file_range.c -o /root/cfr || exit=0Amount=
 -t nfs -o vers=3D4.2 localhost:/nfsexport/ /nfsmnt || exit=0Amount | grep =
nfsmnt=0Acd /nfsmnt=0Afor i in 0 17 4095 4096 4097 ; do		  # in offset=0A	f=
or j in 0 17 4095 4096 4097 ; do	  # out offset=0A		for k in 11 4095 4096 4=
097 ; do   # len=0A			echo ABCDEFGHIJKLMNOPQRSTUVWXYZ12345 > 1=0A			echo AB=
CDEFGHIJKLMNOPQRSTUVWXYZ12345 > 2=0A			sync=0A			/root/cfr 1 2 $i $j $k=0A	=
	done=0A	done=0Adone=0Acd=0Aumount /nfsmnt=0Asystemctl stop nfs-server=0Arm=
 -f test.img=0A
--gntlxg3aq5x7mobf--
