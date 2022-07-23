Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5FE57F08B
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Jul 2022 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiGWRGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sat, 23 Jul 2022 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 23 Jul 2022 13:06:43 -0400
X-Greylist: delayed 4365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Jul 2022 10:06:42 PDT
Received: from web1.siteocity.com (web1.siteocity.com [172.241.25.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68171AF2E
        for <linux-nfs@vger.kernel.org>; Sat, 23 Jul 2022 10:06:42 -0700 (PDT)
Received: from mailnull by web1.siteocity.com with spam-scanner (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oFHS1-00027K-7e
        for linux-nfs@vger.kernel.org;
        Sat, 23 Jul 2022 10:53:57 -0500
X-ImunifyEmail-Filter-Info: ewogICAgImlzX3NraXBwZWQiOiBmYWxzZSwKICAgICJ0aW1lX3JlYWw
        iOiAwLjQ5NjM3MywKICAgICJzeW1ib2xzIjogewogICAgICAgICJCQV
        lFU19IQU0iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAtM
        ywKICAgICAgICAgICAgIm9wdGlvbnMiOiBbCiAgICAgICAgICAgICAg
        ICAiOTkuOTQlIgogICAgICAgICAgICBdLAogICAgICAgICAgICAiZGV
        zY3JpcHRpb24iOiAiTWVzc2FnZSBwcm9iYWJseSBoYW0sIHByb2JhYm
        lsaXR5OiAiLAogICAgICAgICAgICAibmFtZSI6ICJCQVlFU19IQU0iL
        AogICAgICAgICAgICAic2NvcmUiOiAtMi45ODU2ODQKICAgICAgICB9
        LAogICAgICAgICJNSU1FX1VOS05PV04iOiB7CiAgICAgICAgICAgICJ
        tZXRyaWNfc2NvcmUiOiAwLjEwMDAwMCwKICAgICAgICAgICAgIm9wdG
        lvbnMiOiBbCiAgICAgICAgICAgICAgICAidGV4dC9wbGFpbiIKICAgI
        CAgICAgICAgXSwKICAgICAgICAgICAgImRlc2NyaXB0aW9uIjogIk1p
        c3Npbmcgb3IgdW5rbm93biBjb250ZW50LXR5cGUiLAogICAgICAgICA
        gICAibmFtZSI6ICJNSU1FX1VOS05PV04iLAogICAgICAgICAgICAic2
        NvcmUiOiAwLjEwMDAwMAogICAgICAgIH0sCiAgICAgICAgIk1JRF9SS
        FNfTUFUQ0hfRlJPTSI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29y
        ZSI6IDAsCiAgICAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJNZXNzYWd
        lLUlEIFJIUyBtYXRjaGVzIEZyb20gZG9tYWluIiwKICAgICAgICAgIC
        AgIm5hbWUiOiAiTUlEX1JIU19NQVRDSF9GUk9NIiwKICAgICAgICAgI
        CAgInNjb3JlIjogMAogICAgICAgIH0sCiAgICAgICAgIlJDVkRfVExT
        X0FMTCI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiA
        gICAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJBbGwgaG9wcyB1c2VkIG
        VuY3J5cHRlZCB0cmFuc3BvcnRzIiwKICAgICAgICAgICAgIm5hbWUiO
        iAiUkNWRF9UTFNfQUxMIiwKICAgICAgICAgICAgInNjb3JlIjogMAog
        ICAgICAgIH0sCiAgICAgICAgIkFSQ19OQSI6IHsKICAgICAgICAgICA
        gIm1ldHJpY19zY29yZSI6IDAsCiAgICAgICAgICAgICJkZXNjcmlwdG
        lvbiI6ICJBUkMgc2lnbmF0dXJlIGFic2VudCIsCiAgICAgICAgICAgI
        CJuYW1lIjogIkFSQ19OQSIsCiAgICAgICAgICAgICJzY29yZSI6IDAK
        ICAgICAgICB9LAogICAgICAgICJBU04iOiB7CiAgICAgICAgICAgICJ
        tZXRyaWNfc2NvcmUiOiAwLAogICAgICAgICAgICAib3B0aW9ucyI6IF
        sKICAgICAgICAgICAgICAgICJhc246MzM1MjIsIGlwbmV0OjE4NC45N
        C4xOTIuMC8yMCwgY291bnRyeTpVUyIKICAgICAgICAgICAgXSwKICAg
        ICAgICAgICAgIm5hbWUiOiAiQVNOIiwKICAgICAgICAgICAgInNjb3J
        lIjogMAogICAgICAgIH0sCiAgICAgICAgIkZST01fRVFfRU5WRlJPTS
        I6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgI
        CAgICAgICJkZXNjcmlwdGlvbiI6ICJGcm9tIGFkZHJlc3MgaXMgdGhl
        IHNhbWUgYXMgdGhlIGVudmVsb3BlIiwKICAgICAgICAgICAgIm5hbWU
        iOiAiRlJPTV9FUV9FTlZGUk9NIiwKICAgICAgICAgICAgInNjb3JlIj
        ogMAogICAgICAgIH0sCiAgICAgICAgIlNVQkpFQ1RfRU5EU19RVUVTV
        ElPTiI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDEsCiAg
        ICAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJTdWJqZWN0IGVuZHMgd2l
        0aCBhIHF1ZXN0aW9uIiwKICAgICAgICAgICAgIm5hbWUiOiAiU1VCSk
        VDVF9FTkRTX1FVRVNUSU9OIiwKICAgICAgICAgICAgInNjb3JlIjogM
        QogICAgICAgIH0sCiAgICAgICAgIlJDVkRfVklBX1NNVFBfQVVUSCI6
        IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgICA
        gICAgICJkZXNjcmlwdGlvbiI6ICJBdXRoZW50aWNhdGVkIGhhbmQtb2
        ZmIHdhcyBzZWVuIGluIFJlY2VpdmVkIGhlYWRlcnMiLAogICAgICAgI
        CAgICAibmFtZSI6ICJSQ1ZEX1ZJQV9TTVRQX0FVVEgiLAogICAgICAg
        ICAgICAic2NvcmUiOiAwCiAgICAgICAgfSwKICAgICAgICAiRlJPTV9
        IQVNfRE4iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAwLA
        ogICAgICAgICAgICAiZGVzY3JpcHRpb24iOiAiRnJvbSBoZWFkZXIga
        GFzIGEgZGlzcGxheSBuYW1lIiwKICAgICAgICAgICAgIm5hbWUiOiAi
        RlJPTV9IQVNfRE4iLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICA
        gICAgfSwKICAgICAgICAiVE9fRE5fTk9ORSI6IHsKICAgICAgICAgIC
        AgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgICAgICAgICJkZXNjcmlwd
        GlvbiI6ICJOb25lIG9mIHRoZSByZWNpcGllbnRzIGhhdmUgZGlzcGxh
        eSBuYW1lcyIsCiAgICAgICAgICAgICJuYW1lIjogIlRPX0ROX05PTkU
        iLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAgICAgfSwKICAgIC
        AgICAiUkNQVF9DT1VOVF9PTkUiOiB7CiAgICAgICAgICAgICJtZXRya
        WNfc2NvcmUiOiAwLAogICAgICAgICAgICAib3B0aW9ucyI6IFsKICAg
        ICAgICAgICAgICAgICIxIgogICAgICAgICAgICBdLAogICAgICAgICA
        gICAiZGVzY3JpcHRpb24iOiAiT25lIHJlY2lwaWVudCIsCiAgICAgIC
        AgICAgICJuYW1lIjogIlJDUFRfQ09VTlRfT05FIiwKICAgICAgICAgI
        CAgInNjb3JlIjogMAogICAgICAgIH0sCiAgICAgICAgIk1WX0NBU0Ui
        OiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAwLjUwMDAwMCw
        KICAgICAgICAgICAgImRlc2NyaXB0aW9uIjogIk1pbWUtVmVyc2lvbi
        AudnMuIE1JTUUtVmVyc2lvbiIsCiAgICAgICAgICAgICJuYW1lIjogI
        k1WX0NBU0UiLAogICAgICAgICAgICAic2NvcmUiOiAwLjUwMDAwMAog
        ICAgICAgIH0sCiAgICAgICAgIlRPX01BVENIX0VOVlJDUFRfQUxMIjo
        gewogICAgICAgICAgICAibWV0cmljX3Njb3JlIjogMCwKICAgICAgIC
        AgICAgImRlc2NyaXB0aW9uIjogIkFsbCBvZiB0aGUgcmVjaXBpZW50c
        yBtYXRjaCB0aGUgZW52ZWxvcGUiLAogICAgICAgICAgICAibmFtZSI6
        ICJUT19NQVRDSF9FTlZSQ1BUX0FMTCIsCiAgICAgICAgICAgICJzY29
        yZSI6IDAKICAgICAgICB9LAogICAgICAgICJNSU1FX1RSQUNFIjogew
        ogICAgICAgICAgICAibWV0cmljX3Njb3JlIjogMCwKICAgICAgICAgI
        CAgIm9wdGlvbnMiOiBbCiAgICAgICAgICAgICAgICAiMDp+IgogICAg
        ICAgICAgICBdLAogICAgICAgICAgICAibmFtZSI6ICJNSU1FX1RSQUN
        FIiwKICAgICAgICAgICAgInNjb3JlIjogMAogICAgICAgIH0sCiAgIC
        AgICAgIlJDVkRfQ09VTlRfT05FIjogewogICAgICAgICAgICAibWV0c
        mljX3Njb3JlIjogMCwKICAgICAgICAgICAgIm9wdGlvbnMiOiBbCiAg
        ICAgICAgICAgICAgICAiMSIKICAgICAgICAgICAgXSwKICAgICAgICA
        gICAgImRlc2NyaXB0aW9uIjogIk1lc3NhZ2UgaGFzIG9uZSBSZWNlaX
        ZlZCBoZWFkZXIiLAogICAgICAgICAgICAibmFtZSI6ICJSQ1ZEX0NPV
        U5UX09ORSIsCiAgICAgICAgICAgICJzY29yZSI6IDAKICAgICAgICB9
        CiAgICB9LAogICAgInJlcXVpcmVkX3Njb3JlIjogMTUsCiAgICAibWV
        zc2FnZXMiOiB7fSwKICAgICJhY3Rpb24iOiAibm8gYWN0aW9uIiwKIC
        AgICJtZXNzYWdlLWlkIjogIjRBOTY0NDI4LTY1RUEtNDlENC1CN0I0L
        TM1RDIyRDg5RDQxOEBmZWxpcGVnYXNwZXIuY29tIiwKICAgICJzY29y
        ZSI6IC0xLjM4NTY4NAp9
X-ImunifyEmail-Filter-Score: -1.3856842059629
X-ImunifyEmail-Filter-Action: no action
Received: from hou-4.nat.cptxoffice.net ([184.94.197.4]:64482 helo=smtpclient.apple)
        by web1.siteocity.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oFHS4-00026w-QM
        for linux-nfs@vger.kernel.org;
        Sat, 23 Jul 2022 10:53:56 -0500
From:   Felipe Gasper <felipe@felipegasper.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Supplementary GIDs?
Message-Id: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
Date:   Sat, 23 Jul 2022 11:53:55 -0400
To:     linux-nfs@vger.kernel.org
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

	I’m seeing two different behaviours between kernel NFS server versions in AlmaLinux 8 and Ubuntu 20. The following Perl demonstrates the issue:

--------
perl -MFile::Temp -Mautodie -Mstrict -e'my $fh = File::Temp::tempfile( DIR => "/the/nfs/mount" ); my $mailgid = getgrnam "mail"; my ($uid, $gid) = (getpwnam "bin")[2,3]; chown $uid, $gid, $fh; $) = "$gid $mailgid"; $> = $uid; chown -1, $mailgid, $fh'
--------

	What this does, as root, is:

1) Creates a file under /mnt, then deletes it, leaving the Linux file descriptor open.

2) chowns the file to bin:bin.

3) Sets the process’s EUID & GUID to bin & bin/mail.

4) Does fchown( fd, -1, mailgid ).

	When the server is AlmaLinux 8, the above works. When the server is Ubuntu 20, it fails with EPERM. (The client is AlmaLinux 8 in both cases.) Both are configured identically.

	Does anyone know of anything that changed fairly recently in the kernel’s NFS server that might affect this? I’ve done a packet capture and confirmed that in both cases there’s an NFS SETATTR sent in an RPC 2.4 packet whose UID & GIDs match the process.

	Thank you in advance!

cheers,
-Felipe
