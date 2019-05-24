Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1BC298AD
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2019 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391408AbfEXNP0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 May 2019 09:15:26 -0400
Received: from hr2.samba.org ([144.76.82.148]:25870 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391629AbfEXNP0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 May 2019 09:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:Cc:To:From:Date;
        bh=NSe0jTdWcOrCzCNlDrZ60H7S/FgK23ntBqPpIUtSdps=; b=raUmvMHd5BngkHaK4WuMRGy29z
        f0wKvD+9npBn8CX0KfwTSEPHOsaPL3lC6QXOSQJiN7xJ2bqM3gNKarqqE+GkCEniuM/FTsmt7YMw2
        xFWsuChbuYyKsMIgQqN99ABcmpeV2AZoXuoGZtDoBr5cEHfIa5QxIGs8HTz1AMkKSsw0=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1hUA2a-0001dR-B2; Fri, 24 May 2019 13:15:20 +0000
Date:   Fri, 24 May 2019 15:15:17 +0200
From:   Ralph Boehme <slow@samba.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Ralph =?utf-8?B?QsO2aG1l?= <slow@samba.org>,
        Jeremy Allison <jra@samba.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Volker.Lendecke@sernet.de, devel@lists.nfs-ganesha.org,
        Jeff Layton <jlayton@kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
Message-ID: <20190524131517.5i3c63fytz3jansf@inti>
References: <CAOQ4uxjxQoCWqfp+f91--tyR81PREsssT=RV9uRgCQFs+yk7mw@mail.gmail.com>
 <20190214210652.GC9216@fieldses.org>
 <20190305214748.GD27437@fieldses.org>
 <20190306151150.GC2426@fieldses.org>
 <1ade4724a4e505baf7b7c23a76e44d58b931da1f.camel@kernel.org>
 <20190306210743.GE19279@jra3>
 <F00A0481-0AC7-411E-8353-BF104713F524@samba.org>
 <5ebdb58b-26d9-c0f2-bd67-883bc4678ac7@samba.org>
 <CAOQ4uxiBLw_L=SqCjLU6W60LbtWiLaBh=5Cb4HnSAFqCW0z1WA@mail.gmail.com>
 <CAOQ4uxiJQj+wvL8UxfDWe+BAD_7cmHBa5Z3L5Gv0LaDc2TKgUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiJQj+wvL8UxfDWe+BAD_7cmHBa5Z3L5Gv0LaDc2TKgUg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 24, 2019 at 10:12:10AM +0300, Amir Goldstein wrote:
>I will be attending SambaXP, so if any of the Samba guys would like to, we could
>find a slot in the Hallway track or at a local bar to discuss those options.

awesome! I'll join as well.

Looking forward to see you at SambaXP!
-slow

-- 
Ralph Boehme, Samba Team                https://samba.org/
Samba Developer, SerNet GmbH   https://sernet.de/en/samba/
GPG-Fingerprint   FAE2C6088A24252051C559E4AA1E9B7126399E46
