Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEB20B6DA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgFZRYA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 13:24:00 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:49689 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgFZRYA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 13:24:00 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jos4y-0006Rk-48; Fri, 26 Jun 2020 12:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rN6T/U+RsmKKpxZnPoPMRv63h2tuv+JnQsicgMQ/o5M=; b=daDcRJ02EOIShLsdQsK/by37cr
        kuQ/tZin93RKRrnIdKnDkJu9r76wKp3kobONFtraEaTOgk2WWreUgS45Ca8yrhVu0ISlAgO22gq33
        8x1qMSdn2vYMb64xVHq9SuM1S6YCXt7UKbFshxeMaXCNXNHQ1bSWnBUXSAY72viRdhdBfGmDJpqVl
        eNxqizhiNdHd0FjwZ6TrhtV27iZoWJ2v+aVQWPgEDyIHj4fu8VIlNaCBzs/xN3gXKRP/Pu+RYsGHl
        W1oUTFQrhpcb9MCMP63gdKpJWdI115aX1AT5tOqPt58JrgmJqLxeFNJn6aCOW/uLId75EvDlsfjA+
        /3ZmILYw==;
Received: from [174.119.114.224] (port=61454 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jos4w-00051S-N9; Fri, 26 Jun 2020 13:23:54 -0400
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
Date:   Fri, 26 Jun 2020 13:23:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVN9/jV5EUV+R+
 MIuZPY1qHETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K0u7bp06KWZE5kJo1RQt2r0uc
 7AzjRBXOY6yVfGpMIXfS8FYbT30fGHQ1v2jpPnlJV72ZlMoYFW/iILNesMKWB6DY4cCrsCyAwHoj
 HGSwEc8CUhteWi9sZ0/D91cArp6AOFxptQZjDXBvE/1GWErfjgK/NzaQ0kU5LIjXaSmvljwhyk8Q
 3euhueWKWlOW4QobXxusReGs8D5s+BpOoqsKPHnEEeQIwKMymizPrn975/qMR6RnXDqOz0oQYKSM
 2MZ1trSG+zanhVH6MyN4UABWXkpCHkq3t2QWc5y7R2vgTKTvxnrnHtOKPp7r4O3DezwNkL/+h1aL
 2OqtpSX2AHJEJUCbUeEMVjDon5rfSznEF9Wn0xds8xzlI9bNNBd60UaaLFOTFOSXhInfKu2LaPOi
 g0Tz8DRKXZMehWGgJjrhqyz6Bfy1T3PwsUos1yNYdTOG17NirEYyqwqMBGrw8ELiqOQm0t959gAh
 KvRa1vmpN2P40gxJLR2O3anAdXM16WBTRUFUU5/JtLKKEUu4esXRICk4xAm9D8KTeKJT7gNACPd+
 nNEjPOAcc2mSKil38RhC5WpVRRy7ey4Vrj8oN0DwH5zchTwz5HNHuVi9qs3XQ4g9UEcAqj5WY48d
 cOGI362IOtpGvb27fFG7dRl/E9ELIH5e90wcVfDxixi0L/Em6K0oqBBzZqz34WAUSeMDkO8xLypP
 fi/26oO2cauHDD/6kTRqq9XJ3A7TbtUilHMjAbMQ9r701nWrAsLwohWm7wYLeHkNjfXxRRqyRbYy
 SsHpHFs8nMl+yGjEm2w3RnM9LLcccBIk1Sag4dKiqCrF8eZZ3gAFgf5pxcvjqhYUkJ+PVcagBWhr
 PqYGcDoUB+MVMogTqfDNG/eSEDCU3zUmlBVgZvOugleMfvBA1j+Q7fKKz3fccSHpoEA6x1E6NCAy
 03IIEaw2FATNOSyR0hlRJ2bU83KrEXc+Z1DahbUFzBX4rvXS1+qgaVt1ORMtpYIBctpo5lIZ42Pp
 IMd67+j9MC/iEbKoMM0R+bccIbn7fCdCag==
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-06-26 08:31, Kraus, Sebastian wrote:
> Hi Doug, Dear Bruce,
> FYI, I filed a bug with nfs-common package in Debian Buster:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=963746
>
> Hope this helps to track down the problem further and shed some light on the mysterious segfaults of rpc.gssd.

Ok, I think I see what's going on. The struct clnt_info is getting freed 
out from under the upcall thread. In this case it immediately got reused 
for another client which zeroed the struct and was in the process of 
looking up the info for it's client, hence the protocol & server fields 
were null in the upcall thread.

Explains why I haven't been able to recreate it. Thanks for the stack 
trace Sebastian.

Bruce, I can't see any locking/reference counting around struct 
clnt_info. It just gets destroyed when receiving the inotify. Or should 
it be deep copied when starting an upcall? Am I missing something?

Doug

Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt50e) ev->mask (0x40000100)
Jun 25 11:46:08 server rpc.gssd[6356]: handle_gssd_upcall: 'mech=krb5 uid=0 target=host@client.domain.tu-berlin.de service=nfs enctypes=18,17,16,23,3,1,2 ' (nfsd4_cb/clnt50e)
Jun 25 11:46:08 server rpc.gssd[6356]: krb5_use_machine_creds: uid 0 tgtname host@client.domain.tu-berlin.de
Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (krb5) ev->mask (0x00000200)
Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (gssd) ev->mask (0x00000200)
Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (info) ev->mask (0x00000200)
Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for clntdir (nfsd4_cb/clnt50e) - ev->wd (75) ev->name (<?>) ev->mask (0x00008000)
Jun 25 11:46:08 server rpc.gssd[6356]: inotify event for topdir (nfsd4_cb) - ev->wd (5) ev->name (clnt50f) ev->mask (0x40000100)
Jun 25 11:46:08 server rpc.gssd[6356]: Full hostname for '' is 'client.domain.tu-berlin.de'
Jun 25 11:46:08 server rpc.gssd[6356]: Full hostname for 'server.domain.tu-berlin.de' is 'server.domain.tu-berlin.de'
Jun 25 11:46:08 server rpc.gssd[6356]: Success getting keytab entry for 'nfs/server.domain.tu-berlin.de@TU-BERLIN.DE'
Jun 25 11:46:08 server rpc.gssd[6356]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1593101766
Jun 25 11:46:08 server rpc.gssd[6356]: INFO: Credentials in CC 'FILE:/tmp/krb5ccmachine_TU-BERLIN.DE' are good until 1593101766
Jun 25 11:46:08 server rpc.gssd[6356]: creating (null) client for server (null)
Jun 25 11:46:08 all kernel: rpc.gssd[14174]: segfault at 0 ip 000056233fff038e sp 00007fb2eaeb9880 error 4 in rpc.gssd[56233ffed000+9000]


Thread 1 (Thread 0x7fb2eaeba700 (LWP 14174)):
#0  0x000056233fff038e in create_auth_rpc_client (clp=clp@entry=0x562341008fa0, tgtname=tgtname@entry=0x562341011c8f "host@client.domain.tu-berlin.de", clnt_return=clnt_return@entry=0x7fb2eaeb9de8, auth_return=auth_return@entry=0x7fb2eaeb9d50, uid=uid@entry=0, cred=cred@entry=0x0, authtype=0) at gssd_proc.c:352

Thread 2 (Thread 0x7fb2eb6d9740 (LWP 6356)):
#12 0x000056233ffef82c in gssd_read_service_info (clp=0x562341008fa0, dirfd=11) at gssd.c:326


