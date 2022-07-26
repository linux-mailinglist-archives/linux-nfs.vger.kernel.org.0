Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED464581154
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiGZKkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 26 Jul 2022 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGZKkf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 06:40:35 -0400
Received: from web1.siteocity.com (web1.siteocity.com [172.241.25.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8580E0F1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 03:40:33 -0700 (PDT)
Received: from mailnull by web1.siteocity.com with spam-scanner (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oGHzM-0002zi-O7
        for linux-nfs@vger.kernel.org;
        Tue, 26 Jul 2022 05:40:32 -0500
X-ImunifyEmail-Filter-Info: ewogICAgImlzX3NraXBwZWQiOiBmYWxzZSwKICAgICJ0aW1lX3JlYWw
        iOiAwLjMyMzUwNCwKICAgICJzeW1ib2xzIjogewogICAgICAgICJCQV
        lFU19IQU0iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAtM
        ywKICAgICAgICAgICAgIm9wdGlvbnMiOiBbCiAgICAgICAgICAgICAg
        ICAiOTkuOTklIgogICAgICAgICAgICBdLAogICAgICAgICAgICAiZGV
        zY3JpcHRpb24iOiAiTWVzc2FnZSBwcm9iYWJseSBoYW0sIHByb2JhYm
        lsaXR5OiAiLAogICAgICAgICAgICAibmFtZSI6ICJCQVlFU19IQU0iL
        AogICAgICAgICAgICAic2NvcmUiOiAtMi45OTgxNDcKICAgICAgICB9
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
        AgICJzY29yZSI6IDAKICAgICAgICB9LAogICAgICAgICJGUk9NX0VRX
        0VOVkZST00iOiB7CiAgICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAw
        LAogICAgICAgICAgICAiZGVzY3JpcHRpb24iOiAiRnJvbSBhZGRyZXN
        zIGlzIHRoZSBzYW1lIGFzIHRoZSBlbnZlbG9wZSIsCiAgICAgICAgIC
        AgICJuYW1lIjogIkZST01fRVFfRU5WRlJPTSIsCiAgICAgICAgICAgI
        CJzY29yZSI6IDAKICAgICAgICB9LAogICAgICAgICJBU04iOiB7CiAg
        ICAgICAgICAgICJtZXRyaWNfc2NvcmUiOiAwLAogICAgICAgICAgICA
        ib3B0aW9ucyI6IFsKICAgICAgICAgICAgICAgICJhc246MzY0NDUsIG
        lwbmV0OjIwNC42OC4yMzEuMC8yNCwgY291bnRyeTpDQSIKICAgICAgI
        CAgICAgXSwKICAgICAgICAgICAgIm5hbWUiOiAiQVNOIiwKICAgICAg
        ICAgICAgInNjb3JlIjogMAogICAgICAgIH0sCiAgICAgICAgIlJDVkR
        fVklBX1NNVFBfQVVUSCI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY2
        9yZSI6IDAsCiAgICAgICAgICAgICJkZXNjcmlwdGlvbiI6ICJBdXRoZ
        W50aWNhdGVkIGhhbmQtb2ZmIHdhcyBzZWVuIGluIFJlY2VpdmVkIGhl
        YWRlcnMiLAogICAgICAgICAgICAibmFtZSI6ICJSQ1ZEX1ZJQV9TTVR
        QX0FVVEgiLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAgICAgfS
        wKICAgICAgICAiRlJPTV9IQVNfRE4iOiB7CiAgICAgICAgICAgICJtZ
        XRyaWNfc2NvcmUiOiAwLAogICAgICAgICAgICAiZGVzY3JpcHRpb24i
        OiAiRnJvbSBoZWFkZXIgaGFzIGEgZGlzcGxheSBuYW1lIiwKICAgICA
        gICAgICAgIm5hbWUiOiAiRlJPTV9IQVNfRE4iLAogICAgICAgICAgIC
        Aic2NvcmUiOiAwCiAgICAgICAgfSwKICAgICAgICAiUkNWRF9UTFNfQ
        UxMIjogewogICAgICAgICAgICAibWV0cmljX3Njb3JlIjogMCwKICAg
        ICAgICAgICAgImRlc2NyaXB0aW9uIjogIkFsbCBob3BzIHVzZWQgZW5
        jcnlwdGVkIHRyYW5zcG9ydHMiLAogICAgICAgICAgICAibmFtZSI6IC
        JSQ1ZEX1RMU19BTEwiLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgI
        CAgICAgfSwKICAgICAgICAiVE9fRE5fU09NRSI6IHsKICAgICAgICAg
        ICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgICAgICAgICJkZXNjcml
        wdGlvbiI6ICJTb21lIG9mIHRoZSByZWNpcGllbnRzIGhhdmUgZGlzcG
        xheSBuYW1lcyIsCiAgICAgICAgICAgICJuYW1lIjogIlRPX0ROX1NPT
        UUiLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAgICAgfSwKICAg
        ICAgICAiTVZfQ0FTRSI6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29
        yZSI6IDAuNTAwMDAwLAogICAgICAgICAgICAiZGVzY3JpcHRpb24iOi
        AiTWltZS1WZXJzaW9uIC52cy4gTUlNRS1WZXJzaW9uIiwKICAgICAgI
        CAgICAgIm5hbWUiOiAiTVZfQ0FTRSIsCiAgICAgICAgICAgICJzY29y
        ZSI6IDAuNTAwMDAwCiAgICAgICAgfSwKICAgICAgICAiU1VCSkVDVF9
        FTkRTX1FVRVNUSU9OIjogewogICAgICAgICAgICAibWV0cmljX3Njb3
        JlIjogMSwKICAgICAgICAgICAgImRlc2NyaXB0aW9uIjogIlN1YmplY
        3QgZW5kcyB3aXRoIGEgcXVlc3Rpb24iLAogICAgICAgICAgICAibmFt
        ZSI6ICJTVUJKRUNUX0VORFNfUVVFU1RJT04iLAogICAgICAgICAgICA
        ic2NvcmUiOiAxCiAgICAgICAgfSwKICAgICAgICAiTUlNRV9UUkFDRS
        I6IHsKICAgICAgICAgICAgIm1ldHJpY19zY29yZSI6IDAsCiAgICAgI
        CAgICAgICJvcHRpb25zIjogWwogICAgICAgICAgICAgICAgIjA6fiIK
        ICAgICAgICAgICAgXSwKICAgICAgICAgICAgIm5hbWUiOiAiTUlNRV9
        UUkFDRSIsCiAgICAgICAgICAgICJzY29yZSI6IDAKICAgICAgICB9LA
        ogICAgICAgICJSQ1ZEX0NPVU5UX09ORSI6IHsKICAgICAgICAgICAgI
        m1ldHJpY19zY29yZSI6IDAsCiAgICAgICAgICAgICJvcHRpb25zIjog
        WwogICAgICAgICAgICAgICAgIjEiCiAgICAgICAgICAgIF0sCiAgICA
        gICAgICAgICJkZXNjcmlwdGlvbiI6ICJNZXNzYWdlIGhhcyBvbmUgUm
        VjZWl2ZWQgaGVhZGVyIiwKICAgICAgICAgICAgIm5hbWUiOiAiUkNWR
        F9DT1VOVF9PTkUiLAogICAgICAgICAgICAic2NvcmUiOiAwCiAgICAg
        ICAgfQogICAgfSwKICAgICJyZXF1aXJlZF9zY29yZSI6IDE1LAogICA
        gIm1lc3NhZ2VzIjoge30sCiAgICAiYWN0aW9uIjogIm5vIGFjdGlvbi
        IsCiAgICAibWVzc2FnZS1pZCI6ICIzRkJGOUVDNy1EMzM3LTRDMEUtQ
        UYzMC1BNkYxNTQ4QUJDN0NAZmVsaXBlZ2FzcGVyLmNvbSIsCiAgICAi
        c2NvcmUiOiAtMS4zOTgxNDcKfQ==
X-ImunifyEmail-Filter-Score: -1.398146687861
X-ImunifyEmail-Filter-Action: no action
Received: from [204.68.231.176] (port=49184 helo=smtpclient.apple)
        by web1.siteocity.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <felipe@felipegasper.com>)
        id 1oGHzM-0002zA-95;
        Tue, 26 Jul 2022 05:40:32 -0500
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Felipe Gasper <felipe@felipegasper.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Supplementary GIDs?
Date:   Tue, 26 Jul 2022 06:40:30 -0400
Message-Id: <3FBF9EC7-D337-4C0E-AF30-A6F1548ABC7C@felipegasper.com>
References: <165881171619.4359.3075025793434550604@noble.neil.brown.name>
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <165881171619.4359.3075025793434550604@noble.neil.brown.name>
To:     NeilBrown <neilb@suse.de>
X-Mailer: iPhone Mail (19F77)
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



> On Jul 26, 2022, at 01:02, NeilBrown <neilb@suse.de> wrote:
> 
> ﻿On Sun, 24 Jul 2022, Felipe Gasper wrote:
>> Hello,
>> 
>>    I’m seeing two different behaviours between kernel NFS server versions in AlmaLinux 8 and Ubuntu 20. The following Perl demonstrates the issue:
>> 
>> --------
>> perl -MFile::Temp -Mautodie -Mstrict -e'my $fh = File::Temp::tempfile( DIR => "/the/nfs/mount" ); my $mailgid = getgrnam "mail"; my ($uid, $gid) = (getpwnam "bin")[2,3]; chown $uid, $gid, $fh; $) = "$gid $mailgid"; $> = $uid; chown -1, $mailgid, $fh'
>> --------
>> 
>>    What this does, as root, is:
>> 
>> 1) Creates a file under /mnt, then deletes it, leaving the Linux file descriptor open.
>> 
>> 2) chowns the file to bin:bin.
>> 
>> 3) Sets the process’s EUID & GUID to bin & bin/mail.
>> 
>> 4) Does fchown( fd, -1, mailgid ).
>> 
>>    When the server is AlmaLinux 8, the above works. When the server is Ubuntu 20, it fails with EPERM. (The client is AlmaLinux 8 in both cases.) Both are configured identically.
>> 
>>    Does anyone know of anything that changed fairly recently in the kernel’s NFS server that might affect this? I’ve done a packet capture and confirmed that in both cases there’s an NFS SETATTR sent in an RPC 2.4 packet whose UID & GIDs match the process.
>> 
> 
> Is mountd on Ubuntu running with "--manage-gids"??  And is mountd on
> AlmaLinux running without that flag?
> 
> That would explain the difference.

Hi Neil,

That is precisely the difference—thank you!

cheers,
-Felipe

