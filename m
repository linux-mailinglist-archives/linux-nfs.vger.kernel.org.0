Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384821257B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGBOAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 10:00:03 -0400
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:45624 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbgGBOAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 10:00:03 -0400
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 10:00:02 EDT
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1jqzSn-0007cU-FJ
        for linux-nfs@vger.kernel.org; Thu, 02 Jul 2020 15:41:17 +0200
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <felix@kngnt.org>)
        id 1jqzSn-0000WN-Bx
        for linux-nfs@vger.kernel.org; Thu, 02 Jul 2020 15:41:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1593697276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32c9Yw1A2229rdGtSfHrzLEQsqVduc1Yw5YwtmPpn1w=;
        b=b3S2vFvUPkjjLQ09DIfgixmQf/hRb8fWrP+dE4EPcZ0nlGHPoqUxQMZQnN21ezhke+TgSo
        GvRwuo6SYNN/ZuDYBBvomQyffQB87XA6ez6Po4I0tYvZKqYfXBxf7bx2JwtgX1tUVMKiw6
        nU2U5qiurvvGjH1iISAFHXLx8Rq8lEiE4jbkxKp4Uvef49Ju5S21xuGCaggh8ZR7QAMBjQ
        cWJ3PflRT1ZZ9jP9dvl46J00cMbB72diIZ92ajCVtp409NE7SIPOSy0UrFcGqQEolyD7gq
        jbfLhThZ0VxfP+m4Him+06alkzXR9T/1Ceg5/lGKvPo8Zz5FtvAvQZn9hx2aAg==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 15:41:16 +0200
From:   Felix Rubio <felix@kngnt.org>
To:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
In-Reply-To: <7B337925-F225-4DD7-A8CF-ECBBE1AC7082@redhat.com>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
 <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
 <b0bcd3e608d6fbc05c0751380f6a0e7b@kngnt.org>
 <7B337925-F225-4DD7-A8CF-ECBBE1AC7082@redhat.com>
Message-ID: <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
X-Sender: felix@kngnt.org
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=Ne99K1L4 c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=fRzrRz4fcqaznMeNCJwA:9 a=mAMb_2uuLs62eYZ6:21 a=nP89TIZLeLxl-2WQ:21 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi everybody

     I am resuscitating a call for help that I issued on February. Maybe 
somebody can give me a hand? On a NFSv4 server, with kerberos 
authentication enabled and working, I have generated a separated export 
that I want to export with only sys authentication. I am stuck exactly 
at the same point where I was :-/.

This is what I have done, so far:

[root@nfs-server etc]# exportfs -v
/export         
10.0.0.0/8(sync,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=krb5:krb5i:krb5p,rw,secure,root_squash,no_all_squash)
/export/home    
10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=krb5:krb5i:krb5p,rw,secure,root_squash,no_all_squash)
/export/smop    
10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
/export/scratch 
10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)

and I still get the same error on the client (here with nfs mount 
debugging enabled):
Jul 02 15:13:44 lfd8-Lx kernel: NFS: nfs mount 
opts='hard,sec=sys,vers=4.1,addr=10.0.2.9,clientaddr=10.1.0.33'
Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 'hard'
Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
'sec=sys'
Jul 02 15:13:44 lfd8-Lx kernel: NFS: parsing sec=sys option
Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
'vers=4.1'
Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
'addr=10.0.2.9'
Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
'clientaddr=10.1.0.33'
Jul 02 15:13:44 lfd8-Lx kernel: NFS: MNTPATH: '/smop'
Jul 02 15:13:44 lfd8-Lx kernel: --> nfs4_try_mount()
Jul 02 15:13:44 lfd8-Lx mount[30152]: mount.nfs4: Operation not 
permitted
Jul 02 15:13:44 lfd8-Lx kernel: <-- nfs4_try_mount() = -1 [error]

getting a trace on the server with 'tshark -i eth0 -p -w 
/tmp/nfs_mount.cap host 10.1.0.33 and port nfs' while running the mount, 
I get:
Running as user "root" and group "root". This could be dangerous.
   1 0.000000000    10.1.0.33 -> 10.0.2.9     NFS 246 V4 Call GETATTR FH: 
0x4bfbf778
   2 0.000097402     10.0.2.9 -> 10.1.0.33    NFS 246 V4 Reply (Call In 
1) GETATTR
   3 0.000790512    10.1.0.33 -> 10.0.2.9     TCP 54 956 > nfs [ACK] 
Seq=193 Ack=193 Win=4565 Len=0
   4 0.416074043    10.1.0.33 -> 10.0.2.9     NFS 206 V4 Call PUTROOTFH | 
GETATTR
   5 0.416209445     10.0.2.9 -> 10.1.0.33    NFS 146 V4 Reply (Call In 
4) PUTROOTFH Status: NFS4ERR_WRONGSEC
   6 0.416853354    10.1.0.33 -> 10.0.2.9     TCP 54 956 > nfs [ACK] 
Seq=345 Ack=285 Win=4565 Len=0

And when displaying the frame #4, I get that it is requesting the 'sys' 
authentication
     Credentials
         Flavor: AUTH_UNIX (1)
         Length: 36
         Stamp: 0x00419352
         Machine Name: lfd8-Lx
             length: 13
             contents: lfd8-Lx
             fill bytes: opaque data
but then, in frame #5, it returns NFS4ERR_WRONGSEC.

This is running a CentOS 7.6 (kernel 3.10.0-1127.13.1.el7.x86_64), just 
updated and rebooted. SElinux is not enforced.

---
Felix Rubio
"Don't believe what you're told. Double check."
