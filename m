Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91A38D659
	for <lists+linux-nfs@lfdr.de>; Sat, 22 May 2021 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhEVPZv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 May 2021 11:25:51 -0400
Received: from bronze1.eecs.yorku.ca ([130.63.94.75]:54302 "EHLO
        bronze1.eecs.yorku.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhEVPZt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 May 2021 11:25:49 -0400
X-Greylist: delayed 2186 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2021 11:25:49 EDT
Received: from [170.133.224.154] (helo=[192.168.1.136])
        by bronze1.eecs.yorku.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2-31-503e55a2c)
        (envelope-from <jas@eecs.yorku.ca>)
        id 1lkSuy-000Jip-UT
        for linux-nfs@vger.kernel.org; Sat, 22 May 2021 10:47:57 -0400
From:   Jason Keltz <jas@eecs.yorku.ca>
Subject: ksu problem with sec=krb5 and nfs
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <abbd93ac-4a68-a471-fbb4-a9baf05b89c9@eecs.yorku.ca>
Date:   Sat, 22 May 2021 10:47:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Score: -101.0
X-Spam-Level: ---------------------------------------------------
X-Spam-Report: Content analysis details:   (-101.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -100 SHORTCIRCUIT           Not all rules were run, due to a shortcircuited
                             rule
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi.

I'm unable to get ksu working wth krb5 NFSv4.  I think I can understand 
why it doesn't work, but I'm looking for help finding a solution.

I am logged into a RHEL7 system as a user "jas" (uid 1004) with working 
Kerberos (using Samba AD).

I want to switch to a user that is tdb (uid 1011) using ksu.

I set up a .k5login file in tdb account containing jas@AD.EECS.YORKU.CA

If tdb home directory is mounted with sec=sys, as jas I can "ksu tdb" 
and it works every time.

If tdb home directory is mounted with sec=krb5, I get permission denied 
unless I enter a password.

(Note that as jas I can still cat ~tdb/.k5login).

KRB5CCNAME is FILE:/tmp/krb5cc_1004 (I can't use the keyring because the 
Kerberos server in Samba doesn't support this on RHEL7).

rpc.gssd -vvv returns:

> handle_gssd_upcall: 'mech=krb5 uid=1011 enctypes=18,17,16,23,3,1,2 ' 
> (nfs/clnt0)
> krb5_not_machine_creds: uid 1011 tgtname (null)
> ERROR: GSS-API: error in gss_acquire_cred(): GSS_S_FAILURE 
> (Unspecified GSS failure.  Minor code may provide more information) - 
> No Kerberos credentials available: Credentials cache permissions 
> incorrect (filename: /tmp/krb5cc_1004)
> looking for client creds with uid 1011 for server sea.eecs.yorku.ca in 
> /tmp
> CC '/tmp/krb5cc_1004' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_1004' owned by 1004, not 1011
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' being considered, with 
> preferred realm 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' owned by 0, not 1011
> CC '/tmp/krb5cc_0' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_0' owned by 0, not 1011
> looking for client creds with uid 1011 for server sea.eecs.yorku.ca in 
> /run/user/%U
> Error doing scandir on directory '/run/user/1011': No such file or 
> directory
> doing error downcall
>
> handle_gssd_upcall: 'mech=krb5 uid=1011 enctypes=18,17,16,23,3,1,2 ' 
> (nfs/clnt0)
> krb5_not_machine_creds: uid 1011 tgtname (null)
> ERROR: GSS-API: error in gss_acquire_cred(): GSS_S_FAILURE 
> (Unspecified GSS failure.  Minor code may provide more information) - 
> No Kerberos credentials available: Credentials cache permissions 
> incorrect (filename: /tmp/krb5cc_1004)
> looking for client creds with uid 1011 for server sea.eecs.yorku.ca in 
> /tmp
> CC '/tmp/krb5cc_1004' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_1004' owned by 1004, not 1011
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' being considered, with 
> preferred realm 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' owned by 0, not 1011
> CC '/tmp/krb5cc_0' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_0' owned by 0, not 1011
> looking for client creds with uid 1011 for server sea.eecs.yorku.ca in 
> /run/user/%U
> Error doing scandir on directory '/run/user/1011': No such file or 
> directory
> doing error downcall

If I actually enter the password then /tmp/krb5cc_1011 shows up, and 
everything works.

> handle_gssd_upcall: 'mech=krb5 uid=1011 enctypes=18,17,16,23,3,1,2 ' 
> (nfs/clnt0)
> krb5_not_machine_creds: uid 1011 tgtname (null)
> ERROR: GSS-API: error in gss_acquire_cred(): GSS_S_FAILURE 
> (Unspecified GSS failure.  Minor code may provide more information) - 
> No Kerberos credentials available: Credentials cache permissions 
> incorrect (filename: /tmp/krb5cc_1004)
> looking for client creds with uid 1011 for server sea.eecs.yorku.ca in 
> /tmp
> CC '/tmp/krb5cc_1004' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_1004' owned by 1004, not 1011
> CC '/tmp/krb5cc_1011.9bpz551G' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC 'FILE:/tmp/krb5cc_1011.9bpz551G'(tdb@AD.EECS.YORKU.CA) passed all 
> checks and has mtime of 1621645808
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' being considered, with 
> preferred realm 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5ccmachine_AD.EECS.YORKU.CA' owned by 0, not 1011
> CC '/tmp/krb5cc_0' being considered, with preferred realm 
> 'AD.EECS.YORKU.CA'
> CC '/tmp/krb5cc_0' owned by 0, not 1011
> using FILE:/tmp/krb5cc_1011.9bpz551G as credentials cache for client 
> with uid 1011 for server sea.eecs.yorku.ca
> using gss_krb5_ccache_name to select krb5 ccache 
> FILE:/tmp/krb5cc_1011.9bpz551G
> creating tcp client for server sea.eecs.yorku.ca
> DEBUG: port already set to 2049
> creating context with server nfs@sea.eecs.yorku.ca
> DEBUG: serialize_krb5_ctx: lucid version!
> prepare_krb5_rfc4121_buffer: protocol 1
> prepare_krb5_rfc4121_buffer: serializing key with enctype 18 and size 32
> doing downcall: lifetime_rec=36000 acceptor=nfs@sea.eecs.yorku.ca

Of course I can exit and the ksu session, and restart it, and it doesn't 
ask for a password because the ticket is in the right place now.

rpc.gssd wouldn't see KRB5CCNAME variable as its a running daemon, but 
it seems to do the right thing looking for the right file in /tmp.

Can someone help me understand the issue, and whether there is a solution?

Jason.

