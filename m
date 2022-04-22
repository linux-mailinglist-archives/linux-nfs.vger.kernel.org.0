Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0B50C510
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Apr 2022 01:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiDVX0r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 19:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiDVX0d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 19:26:33 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2056.outbound.protection.outlook.com [40.107.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5EC12CB
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 16:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWpmHxcl6YyFnZp7qCcE2RhRzDpSfZSRNlfjBGQfH1/1DuPRt2X7Q1nbs8Fi3l4Q6fGP8OJESBLfCOcezB9QwASrzk5LY3ZfAe4Hgv1vlk1IioKdQCBYkdl3bmY6neXdBwoDJq49QnrXbf5H2EGzVlABZG0EGkfsivL9DEaZmYiOQNUJA6bZrYkpRiychA5XZetaEqhfP8ZVXuIxJTJqGZ8ZLvFo8dG61MS1PlB7OSOXBx0YvrRWM8losUyZEWF3ntI7WlVULeEQg/F+2++fbDUmrJxvG/eRyIYolWp+44HPOkdMxkW4a2bS3jFJFQy8eVVqBRthM2pjNoqy/uF/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er79jLiuHDufw3hd+uGM1vVanaZdh0laUX9SnzcnfBs=;
 b=I8mkg7KQUkMF0CRsORCD6bFum7h89HOSnv0fMHG/i8MhO4Z7ouawpb2I8XzU2YA08t7RW+LtJaaj07WO2LrfDzbHHzOk1myAKpCOgs7OzQSr3m/AJqOL3ZLygoIDLf/+Ar5Pmt1qB2zvm4V/iUA4L/j8ZonsJr5SlCHvJoTKZRc8lLa3mqWn+SWRPlHpr7nUO2ywDQoFkecWC8VtLEB/BuZYCbs5R6HeIJDDp0gDk+ArfUudgUExVxuVsVkhvSAEhKFYWNSXLwBub2FjdseMy6s+NF+qm7tFehdR4oixnf+nq29OM+eJJiM+fKgJFr0rIYkZ89Cxp7+LqcaUGnA6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er79jLiuHDufw3hd+uGM1vVanaZdh0laUX9SnzcnfBs=;
 b=abdpjWaQxS4wsJhEvGVFAxBYxYbZmu6kfa7RA9Esyd4mKvCMmLnW5kmFYvb5R2dkKcBE9ujmtGlJtZrgiHAfyT/6u3CpCQ8S79O5SJSQSQzkJypvja8iShRrZJX258mEN92OJihss+EjfftWdFHpZAPfBrO9Gms633Vxumlyltc4bTeQTcxlNuCXGlRuN7VH18D4fwvWKlg6d1d57qN7enbY05YRhaQG/k2V6eB30SZtIKZCMkR/dMEl419V0VWu1qxSFaF+QV55HrSwc3323aZcpSvJQmLI+F5cVXNW4rZErQqpPMDWYmawVmFcoGzzoCv9x69m7FCDxb6sAA9/7w==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YQXPR01MB4434.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 23:03:17 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 23:03:17 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBI=
Date:   Fri, 22 Apr 2022 23:03:17 +0000
Message-ID: <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
In-Reply-To: <20220422151534.GA29913@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f67f0267-2178-46f7-c4f4-1fa41208ecc4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def27c6e-5d6c-47fd-a95b-08da24b44969
x-ms-traffictypediagnostic: YQXPR01MB4434:EE_
x-microsoft-antispam-prvs: <YQXPR01MB4434116DDBDC416E2B5956A5DDF79@YQXPR01MB4434.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3fCNeDJyf1EULinv87hUM3RskU/wAEavDDMH99z/AVGO8DqJGkN2uY+vUsMUCzw/au8pcc1dxhfRKnKA4EkKbXZCpdQkIuANBDE30S9Eiy7X4KUZrwtxGg8OpCY8AqWEpV7WGvRKJkDyzOX+B6WE8EMU6y4/b8Kb7nVgKt3zIj36TI+PQ/wWpsPkeVjUFMvGoUc+VLVALwfKKYHUN0DaQ4Y4+7xSMVvhiKPc+AdpoUVzK5DJ3KFQolu7yidBrlX17gmg+psY25UC9xdz22Y2BQP5Yyx6HKbmlvKz4HRqZBGNT20BcfwGrdz3P98JIhd5lRS2IJMJ8eD0RvkB0tFxhRIOFGC0Q+0x9WNba6AHuqcEyiV4znzpV5KWqJuyFmwpv70uSTaT8owNt3oA5LTAkHR7/jM7F7Ti3Q6qPfJSfQ6/W5oc6wbazazeBLREGdeo47EDTdBEqxOvClgMSjP0RcRSpn8SpMgP0sT3j6hqwxyIRWEi6Zoy8ClMLkGSB3csMLGX3O3gqNPEURIVQ72LBBK04PfSA/IJ5kiphfDSL6vBCiQKYycegjQHQBDkH5Bnqc3kTSJJOmLcJVETp7il9m/x1NUuGGcjsVzAYYqVPT/ELUivcKj7j8Qk/gELtX6kf6Mt10FlvgcdgvbaMpi4jQXFvSDUZqa4SY6hOmAVH5n5dh7aw6ad+Pc8stGWb3aDLe84GKlD4vOKKLk0er0VUZoEVG8SCRjQmt7lJghXPd6dnuGM/qtjLBinC83ieqfYSqNALEn62SzleNZhg0OO+6AQtv96VQf+2xaWKWe484=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(33656002)(9686003)(8936002)(76116006)(786003)(38100700002)(64756008)(122000001)(5660300002)(4326008)(8676002)(91956017)(19627235002)(71200400001)(54906003)(6916009)(2906002)(52536014)(66476007)(66446008)(66556008)(7696005)(316002)(6506007)(55016003)(83380400001)(186003)(508600001)(86362001)(53546011)(966005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C3Dxkmll6Vev2sPUr/qv3MmpzWbiRqcnl1JjGbPBW6dC5I2wsPc1JAmTKt?=
 =?iso-8859-1?Q?XL0WjFY1yfwv4pOzvoznaXx/56sRmLhbefkdoIwO9U8o/pexYTEgbsPRjP?=
 =?iso-8859-1?Q?tDH04rPz502Tzx0f182DCXfYfD51fGAkTblWEJ6M8zUgU0l+eqfm+ZhmbC?=
 =?iso-8859-1?Q?EsL6cvVfdl3e3cOm2aM7RKPBnV6nQHvyxH8c9U6QabAQ3s40u6nlQre+63?=
 =?iso-8859-1?Q?ZfsTwYD25XSWbEzOms4hPhZoVQLyCXNlujIiGnylhMcImHtGQBbWxKzZu0?=
 =?iso-8859-1?Q?3K19GswhL3HCTOO/myS+3zHOs8kKcIWWviYZ0yXTcVibDpRHZPMyM5akT1?=
 =?iso-8859-1?Q?4VW8f4rL7RP1Wjw3BYFKbsgg98c7aRJdiTIHB/Qj6IegfkXN+lEjai0ILI?=
 =?iso-8859-1?Q?4eH/457WDdzECLi7EWvWZgYDxPgpGpH4VWX4dxXPm5dljmXrrd1Lpq11Rd?=
 =?iso-8859-1?Q?BonXzi4iBc6UdY28npOJKMuJRXFGS5Yl58ODTf2g2vUJPdK/sTzchevsJu?=
 =?iso-8859-1?Q?W9kT+JDJgUCdQ2PS9iM8Od75CnecAGgaX2IyQOl+GfHCz0hAjT10EnKiRY?=
 =?iso-8859-1?Q?fN58VSAzJJSYuuMYt0BSNMSrPwALEOVtoa1GrmDW/6gxUtH+My8dsXTpqT?=
 =?iso-8859-1?Q?Agu3diEWOMrSwyLRKbhYGzV/BdaohdqarKu8256t+0WreLRQR9r/RcWaSz?=
 =?iso-8859-1?Q?AlPeHasna7jm8xfId8Kh52p2/RVfMdhADyR6tXlAPQdm33XXwYQ/eAlKpZ?=
 =?iso-8859-1?Q?One6iigUg2KqdzNvBxDGG+3RI76qlKSv5x3U1OBq/ZlTB02yYvILbwVEr7?=
 =?iso-8859-1?Q?TyD/yG4mBktAJBDerm8WjaqPzLULmaOJ1lin36zxEjenoVEGK3lty1LFTa?=
 =?iso-8859-1?Q?1a06I2BJSqfaQT0BH/hxyUg5izfJV6sF3JFRWyJLTGBD7tLq/+V8pMVK8k?=
 =?iso-8859-1?Q?YWa4mh+Lw9DAvemRMpVtKYKsdaEpTa1rMAZo4q5wrqmlXlnJngs5DT+BUu?=
 =?iso-8859-1?Q?wbwH0pQC2PRrWUdHJatRS0xByofMEDxEdd0ms8YhMxxB55v4L0J+Ys60sJ?=
 =?iso-8859-1?Q?yl/yeIY/VLmQZPRzixDpJ33HZTfv3m/HKjamfAu4wSXFSAIwUJ6R48ci/R?=
 =?iso-8859-1?Q?Wo3Ef3aRC3LwvYj2Ng/4hLzkl4SiW478U5vLG6Ap8Hqc1yFiwezYiTbcCR?=
 =?iso-8859-1?Q?ZLB+7/pFqKXSl61J/Z4OQ+JMVMFgzseLTvM1Hb+uKl2ueDvE/a6k7ye01Y?=
 =?iso-8859-1?Q?vprTFrVMer463r1whFq9EJmDhedtUIqMeGLNbMmH2Fg3KJHQZHleHhBtHv?=
 =?iso-8859-1?Q?f9KcaQJ3Ytryj8oCUJZZa6bQSPamafc2vuOq1SAAqiXeCxja2ghsWSZCd5?=
 =?iso-8859-1?Q?TU82B+JEO2Lr9YvDWBKtwNNSiSYN8XsiJ9217xMHEHCmzMpHQXI9Nin1yi?=
 =?iso-8859-1?Q?3ujugHt2beh3z37zQoqJ17pcZnNuGrvw6V5ilyei5DQgVyIAte+rcEI78A?=
 =?iso-8859-1?Q?PULgzqrNPggAtcITbuX6rSH1YmnW2XqCHD8zYlJ5zjTHS89g6UjOJ/sxaZ?=
 =?iso-8859-1?Q?O+Oqpovxgjv8lERda3WZ2mkx/+I5kc9UmIIR9DDsYgxqGxVKYqfq/g8DS3?=
 =?iso-8859-1?Q?Zx1ultNiGxm+rq237nK4zE2949akg7QgxR7pI7ZYXMFqq3fpytNMehdjYV?=
 =?iso-8859-1?Q?9N8SajjUEmYFc/xS2LYg6iS8BhGiSA2aR25KKtRZqjbMX9f6QXS02UHZ56?=
 =?iso-8859-1?Q?hGWI3u/rk5yjvD+QqolcV1AYZHPf8NlecIoub+hV3eKNLyMSYptKZAs2Wu?=
 =?iso-8859-1?Q?rn9Qc0e8Q8GffKivpfMWaPTQDVC/RXnkRO70BKoPxRN1CJ7sqUrhXiN6ud?=
 =?iso-8859-1?Q?+H?=
x-ms-exchange-antispam-messagedata-1: 7vGunixbc2yBrg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: def27c6e-5d6c-47fd-a95b-08da24b44969
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 23:03:17.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C52+ezhW1VLw7PlHCwJIBhCc0WjQsSDxpjEHWaaNfbZ3oThRlUvAs4Ac3FMF5+agR4S4Ne60p1ETPHbKRnlDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB4434
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:=0A=
> On Thu, Apr 21, 2022 at 11:52:32PM +0000, Rick Macklem wrote:=0A=
> > J. Bruce Fields <bfields@fieldses.org> wrote:=0A=
> > [stuff snipped]=0A=
> > > On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:=0A=
> > > >=0A=
> > > >=0A=
> > > > Stale filehandles aren't normal, and suggest some bug or=0A=
> > > > misconfiguration on the server side, either in NFS or the exported=
=0A=
> > > > filesystem.=0A=
> > >=0A=
> > > Actually, I should take that back: if one client removes files while =
a=0A=
> > > second client is using them, it'd be normal for applications on that=
=0A=
> > > second client to see ESTALE.=0A=
> > I took a look at crispyduck's packet trace and here's what I saw:=0A=
> > Packet#=0A=
> > 48 Lookup of test-ovf.vmx=0A=
> > 49 NFS_OK FH is 0x7c9ce14b (the hash)=0A=
> > ...=0A=
> > 51 Open Claim_FH fo 0x7c9ce14b=0A=
> > 52 NFS_OK Open Stateid 0x35be=0A=
> > ...=0A=
> > 138 Rename test-ovf.vmx~ to test-ovf.vmx=0A=
> > 139 NFS_OK=0A=
> > ...=0A=
> > 141 Close with PutFH 0x7c9ce14b=0A=
> > 142 NFS4ERR_STALE for the PutFH=0A=
> >=0A=
> > So, it seems that the Rename will delete the file (names another file t=
o the=0A=
> > same name "test-ovf.vmx".  Then the subsequent Close's PutFH fails,=0A=
> > because the file for the FH has been deleted.=0A=
>=0A=
> Actually (sorry I'm slow to understand this)--why would our 4.1 server=0A=
> ever be returning STALE on a close?  We normally hold a reference to the=
=0A=
> file.=0A=
Well, OPEN_RESULT_PRESERVE_UNLINKED is not set in the Open reply,=0A=
so even if it normally does so, it is not telling the ESXi client that it=
=0A=
will retain it.=0A=
=0A=
> Oh, wait, is subtree_check set on the export?  You don't want to do=0A=
> that.  (The freebsd server probably doesn't even give that as an=0A=
> option?)=0A=
Nope, Never heard of it.=0A=
=0A=
rick=0A=
=0A=
--b.=0A=
=0A=
>=0A=
> Looks like yet another ESXi client bug to me?=0A=
> (I've seen assorted other ones, but not this one. I have no idea how this=
=0A=
>  might work on a FreeBSD server. I can only assume the RPC sequence=0A=
>  ends up different for FreeBSD for some reason? Maybe the Close gets=0A=
>  processed before the Rename? I didn't look at the Sequence args for=0A=
>  these RPCs to see if they use different slots.)=0A=
>=0A=
>=0A=
> > So it might be interesting to know what actually happens when VM=0A=
> > templates are imported.=0A=
> If you look at the packet trace, somewhat weird, like most things for thi=
s=0A=
> client. It does a Lookup of the same file name over and over again, for=
=0A=
> example.=0A=
>=0A=
> > I suppose you could also try NFSv4.0 or try varying kernel versions to=
=0A=
> > try to narrow down the problem.=0A=
> I think it only does NFSv4.1.=0A=
> I've tried to contact the VMware engineers, but never had any luck.=0A=
> I wish they'd show up at a bakeathon, but...=0A=
>=0A=
> > No easy ideas off the top of my head, sorry.=0A=
> I once posted a list of problems I had found with ESXi 6.5 to a FreeBSD=
=0A=
> mailing list and someone who worked for VMware cut/pasted it into their=
=0A=
> problem database.  They responded to him with "might be fixed in a future=
=0A=
> release" and, indeed, they were fixed in ESXi 6.7, so if you can get this=
 to=0A=
> them, they might fix it?=0A=
>=0A=
> rick=0A=
>=0A=
> --b.=0A=
>=0A=
> > Figuring out more than that would require more=0A=
> > investigation.=0A=
> >=0A=
> > --b.=0A=
> >=0A=
> > >=0A=
> > > Br,=0A=
> > > Andi=0A=
> > >=0A=
> > >=0A=
> > >=0A=
> > >=0A=
> > >=0A=
> > >=0A=
> > > Von: Chuck Lever III <chuck.lever@oracle.com>=0A=
> > > Gesendet: Donnerstag, 21. April 2022 16:58=0A=
> > > An: Andreas Nagy <crispyduck@outlook.at>=0A=
> > > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
> > > Betreff: Re: Problems with NFS4.1 on ESXi=0A=
> > >=0A=
> > > Hi Andreas-=0A=
> > >=0A=
> > > > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> =
wrote:=0A=
> > > >=0A=
> > > > Hi,=0A=
> > > >=0A=
> > > > I hope this mailing list is the right place to discuss some problem=
s with nfs4.1.=0A=
> > >=0A=
> > > Well, yes and no. This is an upstream developer mailing list,=0A=
> > > not really for user support.=0A=
> > >=0A=
> > > You seem to be asking about products that are currently supported,=0A=
> > > and I'm not sure if the Debian kernel is stock upstream 5.13 or=0A=
> > > something else. ZFS is not an upstream Linux filesystem and the=0A=
> > > ESXi NFS client is something we have little to no experience with.=0A=
> > >=0A=
> > > I recommend contacting the support desk for your products. If=0A=
> > > they find a specific problem with the Linux NFS server's=0A=
> > > implementation of the NFSv4.1 protocol, then come back here.=0A=
> > >=0A=
> > >=0A=
> > > > Switching from FreeBSD host as NFS server to a Proxmox environment =
also serving NFS I see some strange issues in combination with VMWare ESXi.=
=0A=
> > > >=0A=
> > > > After first thinking it works fine, I started to realize that there=
 are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF=
).=0A=
> > > >=0A=
> > > > Importing ESXi OVF VM Templates fails nearly every time with a ESXi=
 error message "postNFCData failed: Not Found". With NFS3 it is working fin=
e.=0A=
> > > >=0A=
> > > > NFS server is running on a Proxmox host:=0A=
> > > >=0A=
> > > >=A0 root@sepp-sto-01:~# hostnamectl=0A=
> > > >=A0 Static hostname: sepp-sto-01=0A=
> > > >=A0 Icon name: computer-server=0A=
> > > >=A0 Chassis: server=0A=
> > > >=A0 Machine ID: 028da2386e514db19a3793d876fadf12=0A=
> > > >=A0 Boot ID: c5130c8524c64bc38994f6cdd170d9fd=0A=
> > > >=A0 Operating System: Debian GNU/Linux 11 (bullseye)=0A=
> > > >=A0 Kernel: Linux 5.13.19-4-pve=0A=
> > > >=A0 Architecture: x86-64=0A=
> > > >=0A=
> > > >=0A=
> > > > File system is ZFS, but also tried it with others and it is the sam=
e behaivour.=0A=
> > > >=0A=
> > > >=0A=
> > > > ESXi version 7.2U3=0A=
> > > >=0A=
> > > > ESXi vmkernel.log:=0A=
> > > > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortComp=
liance:209: [nsx@6876 comp=3D"nsx-esx" subcomp=3D"vswitch"]client vmk1 requ=
ested promiscuous mode on port 0x4000010, disallowed by vswitch policy=0A=
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)World: 12075:=
 VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3=0A=
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS4=
1: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 faile=
d: Stale file handle=0A=
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=3D936118c3)WARNING: NFS4=
1: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle=
=0A=
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41=
: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed=
: Stale file handle=0A=
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=3D936118c3)WARNING: NFS41=
: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle=
=0A=
> > > > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for V=
PD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported=
=0A=
> > > > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path=
 evaluation for device mpx.vmhba32:C0:T0:L0=0A=
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)World: 12075: =
VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7=0A=
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm =
264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-00=
0000000000/test-ovf/test-ovf.vmx=0A=
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209=
: Creating crypto hash=0A=
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm =
264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-69=
7882ed-0000-000000000000/test-ovf/test-ovf.vmx=0A=
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm =
264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-00=
0000000000/test-ovf/test-ovf.vmx=0A=
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: 209=
: Creating crypto hash=0A=
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=3D9529ace7)VmMemXfer: vm =
264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-69=
7882ed-0000-000000000000/test-ovf/test-ovf.vmx=0A=
> > > >=0A=
> > > > tcpdump taken on the esxi with filter on the nfs server ip is attac=
hed here:=0A=
> > > > https://easyupload.io/xvtpt1=0A=
> > > >=0A=
> > > > I tried to analyze, but have no idea what exactly the problem is. M=
aybe it is some issue with the VMWare implementation?=0A=
> > > > Would be nice if someone with better NFS knowledge could have a loo=
k on the traces.=0A=
> > > >=0A=
> > > > Best regards,=0A=
> > > > cd=0A=
> > >=0A=
> > > --=0A=
> > > Chuck Lever=0A=
> > >=0A=
