Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1B212A62
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGBQwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 12:52:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56610 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGBQwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 12:52:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062GpR60039270;
        Thu, 2 Jul 2020 16:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5fvHQIpn/MhoCVqIOMW0s6j9kTAGyYAfkfVpCxfaHcg=;
 b=Kcjtu5d8QkFGChbAZHqFHsM4Dipc3IWgRIGX46NPYVjzAE9192n9A0DQ+s2s6WhwLn5U
 UMlXLJL5OhtZ7vgtoiUKymitVaOzAzR7n4LYDhuyIn0zkuC65v9fhhcXc4WZNkhg+l1Q
 z4eJDngZUFdimYNJDuwDKWPizVG8nA+mt8BP3OB8Wop1/YwBRozvcC5caiX8KbbmqDsU
 INl84OnZ/adV460nhWqpvdUI2900ZK5Vg9nMh8AUughvefamsygHWL7Mx/DmGsEXu06t
 3IBKPmITPdb+pmi8lVNa6LKZZRfzruUnw+iY98BWMUD1yatwLw3ntICrke46Nu9ddELH OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31ywrbytrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 16:52:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062GmocP189499;
        Thu, 2 Jul 2020 16:52:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31xg19rqmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 16:52:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062GqWqN003318;
        Thu, 2 Jul 2020 16:52:32 GMT
Received: from dhcp-10-154-177-223.vpn.oracle.com (/10.154.177.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 16:52:32 +0000
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
To:     Felix Rubio <felix@kngnt.org>, linux-nfs@vger.kernel.org
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
 <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
 <b0bcd3e608d6fbc05c0751380f6a0e7b@kngnt.org>
 <7B337925-F225-4DD7-A8CF-ECBBE1AC7082@redhat.com>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
Date:   Thu, 2 Jul 2020 09:52:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=975 suspectscore=3 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=985
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=3 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020115
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Felix,

My guess is since '/export' is exported with 'krb5:krb5i:krb5p' and the
exports with 'sys' are underneath it, this might cause the problem when
the mount path of the 'sys' export is traversed on the server. You can
try to move 'smop' and 'sratch' to another subdir.

-Dai

On 7/2/20 6:41 AM, Felix Rubio wrote:
> Hi everybody
>
>     I am resuscitating a call for help that I issued on February. 
> Maybe somebody can give me a hand? On a NFSv4 server, with kerberos 
> authentication enabled and working, I have generated a separated 
> export that I want to export with only sys authentication. I am stuck 
> exactly at the same point where I was :-/.
>
> This is what I have done, so far:
>
> [root@nfs-server etc]# exportfs -v
> /export 
> 10.0.0.0/8(sync,wdelay,hide,crossmnt,no_subtree_check,fsid=0,sec=krb5:krb5i:krb5p,rw,secure,root_squash,no_all_squash)
> /export/home 
> 10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=krb5:krb5i:krb5p,rw,secure,root_squash,no_all_squash)
> /export/smop 
> 10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
> /export/scratch 
> 10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
>
> and I still get the same error on the client (here with nfs mount 
> debugging enabled):
> Jul 02 15:13:44 lfd8-Lx kernel: NFS: nfs mount 
> opts='hard,sec=sys,vers=4.1,addr=10.0.2.9,clientaddr=10.1.0.33'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 'hard'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 'sec=sys'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS: parsing sec=sys option
> Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
> 'vers=4.1'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
> 'addr=10.0.2.9'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS:   parsing nfs mount option 
> 'clientaddr=10.1.0.33'
> Jul 02 15:13:44 lfd8-Lx kernel: NFS: MNTPATH: '/smop'
> Jul 02 15:13:44 lfd8-Lx kernel: --> nfs4_try_mount()
> Jul 02 15:13:44 lfd8-Lx mount[30152]: mount.nfs4: Operation not permitted
> Jul 02 15:13:44 lfd8-Lx kernel: <-- nfs4_try_mount() = -1 [error]
>
> getting a trace on the server with 'tshark -i eth0 -p -w 
> /tmp/nfs_mount.cap host 10.1.0.33 and port nfs' while running the 
> mount, I get:
> Running as user "root" and group "root". This could be dangerous.
>   1 0.000000000    10.1.0.33 -> 10.0.2.9     NFS 246 V4 Call GETATTR 
> FH: 0x4bfbf778
>   2 0.000097402     10.0.2.9 -> 10.1.0.33    NFS 246 V4 Reply (Call In 
> 1) GETATTR
>   3 0.000790512    10.1.0.33 -> 10.0.2.9     TCP 54 956 > nfs [ACK] 
> Seq=193 Ack=193 Win=4565 Len=0
>   4 0.416074043    10.1.0.33 -> 10.0.2.9     NFS 206 V4 Call PUTROOTFH 
> | GETATTR
>   5 0.416209445     10.0.2.9 -> 10.1.0.33    NFS 146 V4 Reply (Call In 
> 4) PUTROOTFH Status: NFS4ERR_WRONGSEC
>   6 0.416853354    10.1.0.33 -> 10.0.2.9     TCP 54 956 > nfs [ACK] 
> Seq=345 Ack=285 Win=4565 Len=0
>
> And when displaying the frame #4, I get that it is requesting the 
> 'sys' authentication
>     Credentials
>         Flavor: AUTH_UNIX (1)
>         Length: 36
>         Stamp: 0x00419352
>         Machine Name: lfd8-Lx
>             length: 13
>             contents: lfd8-Lx
>             fill bytes: opaque data
> but then, in frame #5, it returns NFS4ERR_WRONGSEC.
>
> This is running a CentOS 7.6 (kernel 3.10.0-1127.13.1.el7.x86_64), 
> just updated and rebooted. SElinux is not enforced.
>
> ---
> Felix Rubio
> "Don't believe what you're told. Double check."
