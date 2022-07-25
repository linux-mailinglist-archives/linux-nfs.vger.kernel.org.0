Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAE58033C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 19:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiGYRCV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 25 Jul 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGYRCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 13:02:19 -0400
Received: from web1.siteocity.com (web1.siteocity.com [172.241.25.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58625B876
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 10:02:18 -0700 (PDT)
Received: from mailnull by web1.siteocity.com with spam-scanner (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oG1TF-000234-Mb
        for linux-nfs@vger.kernel.org;
        Mon, 25 Jul 2022 12:02:17 -0500
X-ImunifyEmail-Filter-Info: ewogICAgImlzX3NraXBwZWQiOiBmYWxzZSwKICAgICJ0aW1lX3JlYWw
        iOiAwLjAwNzYyNiwKICAgICJzeW1ib2xzIjogewogICAgICAgICJCQV
        lFU19IQU0iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAtM
        ywKICAgICAgICAgICAgIm9wdGlvbnMiOiBbCiAgICAgICAgICAgICAg
        ICAiOTkuODUlIgogICAgICAgICAgICBdLAogICAgICAgICAgICAiZGV
        zY3JpcHRpb24iOiAiTWVzc2FnZSBwcm9iYWJseSBoYW0sIHByb2JhYm
        lsaXR5OiAiLAogICAgICAgICAgICAibmFtZSI6ICJCQVlFU19IQU0iL
        AogICAgICAgICAgICAic2NvcmUiOiAtMi45NjQ0NzUKICAgICAgICB9
        LAogICAgICAgICJNSU1FX1VOS05PV04iOiB7CiAgICAgICAgICAgICJ
        tZXRyaWNfc2NvcmUiOiAwLjEwMDAwMCwKICAgICAgICAgICAgIm9wdG
        lvbnMiOiBbCiAgICAgICAgICAgICAgICAidGV4dC9wbGFpbiIKICAgI
        CAgICAgICAgXSwKICAgICAgICAgICAgImRlc2NyaXB0aW9uIjogIk1p
        c3Npbmcgb3IgdW5rbm93biBjb250ZW50LXR5cGUiLAogICAgICAgICA
        gICAibmFtZSI6ICJNSU1FX1VOS05PV04iLAogICAgICAgICAgICAic2
        NvcmUiOiAwLjEwMDAwMAogICAgICAgIH0sCiAgICAgICAgIlJDUFRfQ
        09VTlRfVFdPIjogewogICAgICAgICAgICAibWV0cmljX3Njb3JlIjog
        MCwKICAgICAgICAgICAgIm9wdGlvbnMiOiBbCiAgICAgICAgICAgICA
        gICAiMiIKICAgICAgICAgICAgXSwKICAgICAgICAgICAgImRlc2NyaX
        B0aW9uIjogIlR3byByZWNpcGllbnRzIiwKICAgICAgICAgICAgIm5hb
        WUiOiAiUkNQVF9DT1VOVF9UV08iLAogICAgICAgICAgICAic2NvcmUi
        OiAwCiAgICAgICAgfSwKICAgICAgICAiTUlEX1JIU19NQVRDSF9GUk9
        NIjogewogICAgICAgICAgICAibWV0cmljX3Njb3JlIjogMCwKICAgIC
        AgICAgICAgImRlc2NyaXB0aW9uIjogIk1lc3NhZ2UtSUQgUkhTIG1hd
        GNoZXMgRnJvbSBkb21haW4iLAogICAgICAgICAgICAibmFtZSI6ICJN
        SURfUkhTX01BVENIX0ZST00iLAogICAgICAgICAgICAic2NvcmUiOiA
        wCiAgICAgICAgfSwKICAgICAgICAiQVJDX05BIjogewogICAgICAgIC
        AgICAibWV0cmljX3Njb3JlIjogMCwKICAgICAgICAgICAgImRlc2Nya
        XB0aW9uIjogIkFSQyBzaWduYXR1cmUgYWJzZW50IiwKICAgICAgICAg
        ICAgIm5hbWUiOiAiQVJDX05BIiwKICAgICAgICAgICAgInNjb3JlIjo
        gMAogICAgICAgIH0sCiAgICAgICAgIlRPX01BVENIX0VOVlJDUFRfU0
        9NRSI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgI
        CAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJTb21lIG9mIHRoZSByZWNp
        cGllbnRzIG1hdGNoIHRoZSBlbnZlbG9wZSIsCiAgICAgICAgICAgICJ
        uYW1lIjogIlRPX01BVENIX0VOVlJDUFRfU09NRSIsCiAgICAgICAgIC
        AgICJzY29yZSI6IDAKICAgICAgICB9LAogICAgICAgICJBU04iOiB7C
        iAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAwLAogICAgICAgICAg
        ICAib3B0aW9ucyI6IFsKICAgICAgICAgICAgICAgICJhc246MzM1MjI
        sIGlwbmV0OjE4NC45NC4xOTIuMC8yMCwgY291bnRyeTpVUyIKICAgIC
        AgICAgICAgXSwKICAgICAgICAgICAgIm5hbWUiOiAiQVNOIiwKICAgI
        CAgICAgICAgInNjb3JlIjogMAogICAgICAgIH0sCiAgICAgICAgIlRP
        X0ROX0FMTCI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDA
        sCiAgICAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJBbGwgdGhlIHJlY2
        lwaWVudHMgaGF2ZSBkaXNwbGF5IG5hbWVzIiwKICAgICAgICAgICAgI
        m5hbWUiOiAiVE9fRE5fQUxMIiwKICAgICAgICAgICAgInNjb3JlIjog
        MAogICAgICAgIH0sCiAgICAgICAgIlJDVkRfVklBX1NNVFBfQVVUSCI
        6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgIC
        AgICAgICJkZXNjcmlwdGlvbiI6ICJBdXRoZW50aWNhdGVkIGhhbmQtb
        2ZmIHdhcyBzZWVuIGluIFJlY2VpdmVkIGhlYWRlcnMiLAogICAgICAg
        ICAgICAibmFtZSI6ICJSQ1ZEX1ZJQV9TTVRQX0FVVEgiLAogICAgICA
        gICAgICAic2NvcmUiOiAwCiAgICAgICAgfSwKICAgICAgICAiRlJPTV
        9IQVNfRE4iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAwL
        AogICAgICAgICAgICAiZGVzY3JpcHRpb24iOiAiRnJvbSBoZWFkZXIg
        aGFzIGEgZGlzcGxheSBuYW1lIiwKICAgICAgICAgICAgIm5hbWUiOiA
        iRlJPTV9IQVNfRE4iLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgIC
        AgICAgfSwKICAgICAgICAiUkNWRF9UTFNfQUxMIjogewogICAgICAgI
        CAgICAibWV0cmljX3Njb3JlIjogMCwKICAgICAgICAgICAgImRlc2Ny
        aXB0aW9uIjogIkFsbCBob3BzIHVzZWQgZW5jcnlwdGVkIHRyYW5zcG9
        ydHMiLAogICAgICAgICAgICAibmFtZSI6ICJSQ1ZEX1RMU19BTEwiLA
        ogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAgICAgfSwKICAgICAgI
        CAiU1VCSkVDVF9FTkRTX1FVRVNUSU9OIjogewogICAgICAgICAgICAi
        bWV0cmljX3Njb3JlIjogMSwKICAgICAgICAgICAgImRlc2NyaXB0aW9
        uIjogIlN1YmplY3QgZW5kcyB3aXRoIGEgcXVlc3Rpb24iLAogICAgIC
        AgICAgICAibmFtZSI6ICJTVUJKRUNUX0VORFNfUVVFU1RJT04iLAogI
        CAgICAgICAgICAic2NvcmUiOiAxCiAgICAgICAgfSwKICAgICAgICAi
        TVZfQ0FTRSI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDA
        uNTAwMDAwLAogICAgICAgICAgICAiZGVzY3JpcHRpb24iOiAiTWltZS
        1WZXJzaW9uIC52cy4gTUlNRS1WZXJzaW9uIiwKICAgICAgICAgICAgI
        m5hbWUiOiAiTVZfQ0FTRSIsCiAgICAgICAgICAgICJzY29yZSI6IDAu
        NTAwMDAwCiAgICAgICAgfSwKICAgICAgICAiRlJPTV9FUV9FTlZGUk9
        NIjogewogICAgICAgICAgICAibWV0cmljX3Njb3JlIjogMCwKICAgIC
        AgICAgICAgImRlc2NyaXB0aW9uIjogIkZyb20gYWRkcmVzcyBpcyB0a
        GUgc2FtZSBhcyB0aGUgZW52ZWxvcGUiLAogICAgICAgICAgICAibmFt
        ZSI6ICJGUk9NX0VRX0VOVkZST00iLAogICAgICAgICAgICAic2NvcmU
        iOiAwCiAgICAgICAgfSwKICAgICAgICAiTUlNRV9UUkFDRSI6IHsKIC
        AgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgICAgICAgI
        CJvcHRpb25zIjogWwogICAgICAgICAgICAgICAgIjA6fiIKICAgICAg
        ICAgICAgXSwKICAgICAgICAgICAgIm5hbWUiOiAiTUlNRV9UUkFDRSI
        sCiAgICAgICAgICAgICJzY29yZSI6IDAKICAgICAgICB9LAogICAgIC
        AgICJSQ1ZEX0NPVU5UX09ORSI6IHsKICAgICAgICAgICAgIm1ldHJpY
        19zY29yZSI6IDAsCiAgICAgICAgICAgICJvcHRpb25zIjogWwogICAg
        ICAgICAgICAgICAgIjEiCiAgICAgICAgICAgIF0sCiAgICAgICAgICA
        gICJkZXNjcmlwdGlvbiI6ICJNZXNzYWdlIGhhcyBvbmUgUmVjZWl2ZW
        QgaGVhZGVyIiwKICAgICAgICAgICAgIm5hbWUiOiAiUkNWRF9DT1VOV
        F9PTkUiLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAgICAgfQog
        ICAgfSwKICAgICJyZXF1aXJlZF9zY29yZSI6IDE1LAogICAgIm1lc3N
        hZ2VzIjoge30sCiAgICAiYWN0aW9uIjogIm5vIGFjdGlvbiIsCiAgIC
        AibWVzc2FnZS1pZCI6ICJGRkRDN0UwNS0yNkI2LTRDM0EtOUEwOC0yO
        EVCN0UyODc3RDdAZmVsaXBlZ2FzcGVyLmNvbSIsCiAgICAic2NvcmUi
        OiAtMS4zNjQ0NzUKfQ==
X-ImunifyEmail-Filter-Score: -1.3644753383736
X-ImunifyEmail-Filter-Action: no action
Received: from hou-4.nat.cptxoffice.net ([184.94.197.4]:57249 helo=smtpclient.apple)
        by web1.siteocity.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oG1TF-00022O-Oc;
        Mon, 25 Jul 2022 12:02:17 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: Supplementary GIDs?
From:   Felipe Gasper <felipe@felipegasper.com>
In-Reply-To: <869F67CA-812C-4A39-A36E-390EE68241B4@felipegasper.com>
Date:   Mon, 25 Jul 2022 13:02:15 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FFDC7E05-26B6-4C3A-9A08-28EB7E2877D7@felipegasper.com>
References: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
 <7CE7A3E4-118D-4CB0-A952-5DC0014A0882@oracle.com>
 <869F67CA-812C-4A39-A36E-390EE68241B4@felipegasper.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - web1.siteocity.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - felipegasper.com
X-Get-Message-Sender-Via: web1.siteocity.com: mailgid no entry from get_recent_authed_mail_ips_entry
X-Authenticated-Sender: web1.siteocity.com: 
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, no actual sender determined from check mail permissions
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 25, 2022, at 09:29, Felipe Gasper <felipe@felipegasper.com> wrote:
> 
> 
> 
>> On Jul 25, 2022, at 09:23, Chuck Lever III <chuck.lever@oracle.com> wrote:
>> 
>> 
>> 
>>> On Jul 23, 2022, at 11:53 AM, Felipe Gasper <felipe@felipegasper.com> wrote:
>>> 
>>> Hello,
>>> 
>>> 	I’m seeing two different behaviours between kernel NFS server versions in AlmaLinux 8 and Ubuntu 20. The following Perl demonstrates the issue:
>>> 
>>> --------
>>> perl -MFile::Temp -Mautodie -Mstrict -e'my $fh = File::Temp::tempfile( DIR => "/the/nfs/mount" ); my $mailgid = getgrnam "mail"; my ($uid, $gid) = (getpwnam "bin")[2,3]; chown $uid, $gid, $fh; $) = "$gid $mailgid"; $> = $uid; chown -1, $mailgid, $fh'
>>> --------
>>> 
>>> 	What this does, as root, is:
>>> 
>>> 1) Creates a file under /mnt, then deletes it, leaving the Linux file descriptor open.
>>> 
>>> 2) chowns the file to bin:bin.
>>> 
>>> 3) Sets the process’s EUID & GUID to bin & bin/mail.
>>> 
>>> 4) Does fchown( fd, -1, mailgid ).
>>> 
>>> 	When the server is AlmaLinux 8, the above works. When the server is Ubuntu 20, it fails with EPERM. (The client is AlmaLinux 8 in both cases.) Both are configured identically.
>> 
>> On each NFS sever, can you run 'uname -a' and show us the output?
> 
> Ubuntu 20 (the “bad” one):
> root@kvm-demo-support:~# uname -a
> Linux kvm-demo-support 5.4.0-122-generic #138-Ubuntu SMP Wed Jun 22 15:00:31 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> 
> AlmaLinux 8 (the “good” one):
> [root@10-2-71-6 ~]# uname -a
> Linux 10-2-71-6.cprapid.com 4.18.0-372.16.1.el8_6.x86_64 #1 SMP Wed Jul 13 03:56:16 EDT 2022 x86_64 x86_64 x86_64 GNU/Linux
> 
>> 
>> On on the NFS client, can you show us the output of 'nfsstat -m'
>> during each test run?
> 
>> nfsstat -m
> /mnt/phil from kvm-demo-support.dev.cpanel.net:/volumes/kvm-demo
> Flags:	rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.2.65.75,local_lock=none,addr=10.0.32.83
> 
> /mnt/felipe from 10.2.71.6:/home
> Flags:	rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.2.65.75,local_lock=none,addr=10.2.71.6

Update on this: it appears to have been a result of Ubuntu 20’s /etc/default/nfs-kernel-server’s containing `RPCMOUNTDOPTS="--manage-gids"`. Once I commented that line out the issue went away. I also confirmed that AlmaLinux 8 doesn’t enable `--manage-gids`. The varlink traffic in the Ubuntu server to/from rpc.mountd showed that it was asking systemd for the user’s groups and getting an empty response.

Sorry for the noise, and thank you for your time.

cheers,
-Felipe
