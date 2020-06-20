Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BB2026A6
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2020 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgFTVJF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Jun 2020 17:09:05 -0400
Received: from exchange.tu-berlin.de ([130.149.7.70]:43146 "EHLO
        exchange.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgFTVJE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Jun 2020 17:09:04 -0400
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 96EE77DED41_EEE7AEBB;
        Sat, 20 Jun 2020 21:08:59 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id CC66D7DB51C_EEE7AEAF;
        Sat, 20 Jun 2020 21:08:58 +0000 (GMT)
Received: from ex-04.tubit.win.tu-berlin.de (172.26.35.187) by
 EX-MBX05.tubit.win.tu-berlin.de (172.26.35.175) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Sat, 20 Jun 2020 23:08:58 +0200
Received: from ex-02.tubit.win.tu-berlin.de (172.26.35.185) by
 ex-04.tubit.win.tu-berlin.de (172.26.35.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5;
 Sat, 20 Jun 2020 23:08:55 +0200
Received: from ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) by
 ex-02.tubit.win.tu-berlin.de ([172.26.26.142]) with mapi id 15.02.0529.008;
 Sat, 20 Jun 2020 23:08:55 +0200
From:   "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: RPC Pipefs: Frequent parsing errors in client database
Thread-Topic: RPC Pipefs: Frequent parsing errors in client database
Thread-Index: AQHWRn23CLxtUY9z/kmxDmLD+JX3bKjgXLgAgADETmOAAHnYAIAAW/ak
Date:   Sat, 20 Jun 2020 21:08:55 +0000
Message-ID: <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>,<20200620170316.GH1514@fieldses.org>
In-Reply-To: <20200620170316.GH1514@fieldses.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.149.214.191]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PMWin-Version: 4.0.1, Antivirus-Engine: 3.77.1, Antivirus-Data: 5.75
X-PureMessage: [Scanned]
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-transfer-encoding:mime-version; s=dkim-tub; bh=t6aVoP2qJL31FHwrMK9CuakOHCGssY1NTRidIOQ4qEw=; b=WTSgAJQ1B2A/Cvzw4iraf6gj/i5KROjKiOLknAH1sp59dI9MlCnxYsKHQlRrIfpfJIeSHR4t4pZnzsVNLWUEGVij6VdhzZSnSmolgVmVaMOvWDi7jgDIeOoZJL4shbf4d5u0E6+0z9rELyT1b76OroXL9HgPaC2L81ko+kfi+R4=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

>> But I think it'd be more useful to stay focused on the segfaults.

is it a clever idea to analyze core dumps? Or are there other much better d=
ebugging techniques w.r.t. RPC daemons?
I now do more tests while fiddling around with the time-out parameters "-T"=
 and "-t" on the command line of rpc.gssd.

There are several things I do not really understand about the trace shown b=
elow:

1) How can it be useful that the rpc.gssd daemon tries to parse the info fi=
le although it knows about its absence beforehand?
2) Why are there two identifiers clnt36e and clnt36f being used for the sam=
e client?
3) What does the <?> in "inotify event for clntdir (nfsd4_cb/clnt36e) - ev-=
>wd (600) ev->name (<?>) ev->mask (0x00008000)" mean?


Jun 18 18:55:07 server  rpcbind[30464]: connect from 130.149.XXX.YYY to nul=
l()
Jun 18 18:55:07 server  rpcbind[30465]: connect from 130.149.XXX.YYY to get=
port/addr(nfs)
Jun 18 18:55:07 server  rpcbind[30466]: connect from 130.149.XXX.YYY to nul=
l()
Jun 18 18:55:07 server  rpcbind[30467]: connect from 130.149.XXX.YYY to get=
port/addr(nfs)
Jun 18 18:55:07 server  rpcbind[30468]: connect from 130.149.XXX.YYY to nul=
l()
Jun 18 18:55:07 server  rpcbind[30469]: connect from 130.149.XXX.YYY to get=
port/addr(nfs)
Jun 18 18:55:07 server  rpcbind[30470]: connect from 130.149.XXX.YYY to nul=
l()
Jun 18 18:55:07 server  rpcbind[30471]: connect from 130.149.XXX.YYY to get=
port/addr(nfs)
Jun 18 18:55:07 server  rpc.svcgssd[20418]: leaving poll
Jun 18 18:55:07 server  rpc.svcgssd[20418]: handling null request
Jun 18 18:55:07 server  rpc.svcgssd[20418]: svcgssd_limit_krb5_enctypes: Ca=
lling gss_set_allowable_enctypes with 7 enctypes from the kernel
Jun 18 18:55:07 server  rpc.svcgssd[20418]: sname =3D host/client.domain.tu=
-berlin.de@TU-BERLIN.DE
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: calling =
nsswitch->princ_to_ids
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_getpwnam: name 'host/client=
.domain.tu-berlin.de@TU-BERLIN.DE' domain '(null)': resulting localname 'ho=
st/test0815.chem.tu-berlin.de'
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_ldap: reconnecting to LDAP =
server...
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_ldap: reconnected to LDAP s=
erver  ldaps://ldap-server.tu-berlin.de after 1 attempt
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: nsswitch=
->princ_to_ids returned -2
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: final re=
turn value is -2
Jun 18 18:55:07 server  rpc.svcgssd[20418]: DEBUG: serialize_krb5_ctx: luci=
d version!
Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: pr=
otocol 1
Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: se=
rializing key with enctype 18 and size 32
Jun 18 18:55:07 server  rpc.svcgssd[20418]: doing downcall
Jun 18 18:55:07 server  rpc.svcgssd[20418]: mech: krb5, hndl len: 4, ctx le=
n 52, timeout: 1592510348 (11041 from now), clnt: host@client.domain.tu-ber=
lin.de, uid: -1, gid: -1, num aux grps: 0:
Jun 18 18:55:07 server  rpc.svcgssd[20418]: sending null reply
Jun 18 18:55:07 server  rpc.svcgssd[20418]: writing message: \x \x608202cf0=
6092a864886f71201020201006e8202be308202baa003020105a10302010ea2070305002000=
0000a3820194618201903082018ca003020105a10e1b0c54552d4245524c494e2e4445a2273=
025a003020103a11e301c1b036e66731b15616c6c2e6368656d2e74752d6265726c696e2e64=
65a382014a30820146a003
Jun 18 18:55:07 server  rpc.svcgssd[20418]: finished handling null request
Jun 18 18:55:07 server  rpc.svcgssd[20418]: entering poll

Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for topdir (nfsd4_cb=
) - ev->wd (5) ev->name (clnt36e) ev->mask (0x40000100)
Jun 18 18:55:07 server  rpc.gssd[23620]: ERROR: can't open nfsd4_cb/clnt36e=
/info: No such file or directory
Jun 18 18:55:07 server  rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/cl=
nt36e/info

Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_c=
b/clnt36e) - ev->wd (600) ev->name (krb5) ev->mask (0x00000200)
Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_c=
b/clnt36e) - ev->wd (600) ev->name (gssd) ev->mask (0x00000200)
Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_c=
b/clnt36e) - ev->wd (600) ev->name (info) ev->mask (0x00000200)
Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for topdir (nfsd4_cb=
) - ev->wd (5) ev->name (clnt36f) ev->mask (0x40000100)
Jun 18 18:55:07 server  rpc.gssd[23620]: inotify event for clntdir (nfsd4_c=
b/clnt36e) - ev->wd (600) ev->name (<?>) ev->mask (0x00008000)
Jun 18 18:55:07 server  rpc.svcgssd[20418]: leaving poll
Jun 18 18:55:07 server  rpc.svcgssd[20418]: handling null request
Jun 18 18:55:07 server  rpc.gssd[23620]:=20
                                     handle_gssd_upcall: 'mech=3Dkrb5 uid=
=3D0 target=3Dhost@client.domain.tu-berlin.de service=3Dnfs enctypes=3D18,1=
7,16,23,3,1,2 ' (nfsd4_cb/clnt36f)
Jun 18 18:55:07 server  rpc.gssd[23620]: krb5_use_machine_creds: uid 0 tgtn=
ame host@client.domain.tu-berlin.de
Jun 18 18:55:07 server  rpc.svcgssd[20418]: svcgssd_limit_krb5_enctypes: Ca=
lling gss_set_allowable_enctypes with 7 enctypes from the kernel
Jun 18 18:55:07 server  rpc.gssd[23620]: Full hostname for 'client.domain.t=
u-berlin.de' is 'client.domain.tu-berlin.de'
Jun 18 18:55:07 server  rpc.gssd[23620]: Full hostname for 'server.domain.t=
u-berlin.de' is 'server.domain.tu-berlin.de'
Jun 18 18:55:07 server  rpc.gssd[23620]: Success getting keytab entry for '=
nfs/server.domain.tu-berlin.de@TU-BERLIN.DE'
Jun 18 18:55:07 server  rpc.gssd[23620]: INFO: Credentials in CC 'FILE:/tmp=
/krb5ccmachine_TU-BERLIN.DE' are good until 1592526348
Jun 18 18:55:07 server  rpc.gssd[23620]: INFO: Credentials in CC 'FILE:/tmp=
/krb5ccmachine_TU-BERLIN.DE' are good until 1592526348
Jun 18 18:55:07 server  rpc.gssd[23620]: creating tcp client for server  cl=
ient.domain.tu-berlin.de
Jun 18 18:55:07 server  rpc.gssd[23620]: DEBUG: port already set to 39495
Jun 18 18:55:07 server  rpc.gssd[23620]: creating context with server  host=
@client.domain.tu-berlin.de
Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_create_default()
Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_create()
Jun 18 18:55:07 server  rpc.gssd[23620]: authgss_create: name is 0x7fa5ac01=
1970
Jun 18 18:55:07 server  rpc.gssd[23620]: authgss_create: gd->name is 0x7fa5=
ac005770
Jun 18 18:55:07 server  rpc.gssd[23620]: in authgss_refresh()
Jun 18 18:55:07 server  rpc.svcgssd[20418]: sname =3D host/client.domain.tu=
-berlin.de@TU-BERLIN.DE
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: calling =
nsswitch->princ_to_ids
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nss_getpwnam: name 'host/client=
.domain.tu-berlin.de@TU-BERLIN.DE' domain '(null)': resulting localname 'ho=
st/client.domain.tu-berlin.de'
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: nsswitch=
->princ_to_ids returned -2
Jun 18 18:55:07 server  rpc.svcgssd[20418]: nfs4_gss_princ_to_ids: final re=
turn value is -2
Jun 18 18:55:07 server  rpc.svcgssd[20418]: DEBUG: serialize_krb5_ctx: luci=
d version!
Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: pr=
otocol 1
Jun 18 18:55:07 server  rpc.svcgssd[20418]: prepare_krb5_rfc4121_buffer: se=
rializing key with enctype 18 and size 32
Jun 18 18:55:07 server  rpc.svcgssd[20418]: doing downcall
Jun 18 18:55:07 server  rpc.svcgssd[20418]: mech: krb5, hndl len: 4, ctx le=
n 52, timeout: 1592510348 (11041 from now), clnt: host@client.domain.tu-ber=
lin.de, uid: -1, gid: -1, num aux grps: 0:
Jun 18 18:55:07 server  rpc.svcgssd[20418]: sending null reply
Jun 18 18:55:07 server  rpc.svcgssd[20418]: writing message: \x \x608202cf0=
6092a864886f71201020201006e8202be308202baa003020105a10302010ea2070305002000=
0000a3820194618201903082018ca003020105a10e1b0c54552d4245524c494e2e4445a2273=
025a003020103a11e301c1b036e66731b15616c6c2e6368656d2e74752d6265726c696e2e64=
65a382014a30820146a003
Jun 18 18:55:07 server  rpc.svcgssd[20418]: finished handling null request
Jun 18 18:55:07 server  rpc.svcgssd[20418]: entering poll



Best and keep well
Sebastian


Sebastian Kraus
Team IT am Institut f=FCr Chemie
Geb=E4ude C, Stra=DFe des 17. Juni 115, Raum C7

Technische Universit=E4t Berlin
Fakult=E4t II
Institut f=FCr Chemie
Sekretariat C3
Stra=DFe des 17. Juni 135
10623 Berlin

________________________________________
From: J. Bruce Fields <bfields@fieldses.org>
Sent: Saturday, June 20, 2020 19:03
To: Kraus, Sebastian
Cc: linux-nfs@vger.kernel.org
Subject: Re: RPC Pipefs: Frequent parsing errors in client database

On Sat, Jun 20, 2020 at 11:35:56AM +0000, Kraus, Sebastian wrote:
> In consequence, about a week ago, I decided to investigate the problem
> in a deep manner by stracing the rpc.gssd daemon while running.  Since
> then, the segementation violations were gone, but now lots of
> complaints of the following type appear in the system log:
>
>  Jun 19 11:14:00 all rpc.gssd[23620]: ERROR: can't open
>  nfsd4_cb/clnt3bb/info: No such file or directory Jun 19 11:14:00 all
>  rpc.gssd[23620]: ERROR: failed to parse nfsd4_cb/clnt3bb/info
>
>
> This behaviour seems somehow strange to me.  But, one possible
> explanation could be: The execution speed of rpc.gssd slows down while
> being straced and the "true" reason for the segmentation violations
> pops up.  I would argue, rpc.gssd trying to parse non-existing files
> points anyway to an insane and defective behaviour of the RPC GSS user
> space daemon implementation.

Those files under rpc_pipefs come and go.  rpc.gssd monitors directories
under rpc_pipefs to learn about changes, and then tries to parse the
files under any new directories.

The thing is, if rpc.gssd is a little fast, I think it's possible that
it could get the notification about clnt3bb/ being created, and try to
look up "info", before "info" itself is actually created.

Or alternatively, if clnt3bb/ is short-lived, it might not look up
"info" until the directory's already been deleted again.

Neither problem should be fatal--rpc.gssd will get another update and
adjust to the new situation soon enough.

So it may be that the reall error here is an unconditional log message
in a case that's expected, not actually an error.

Or I could be wrong and maybe something else is happening.

But I think it'd be more useful to stay focused on the segfaults.

--b.
