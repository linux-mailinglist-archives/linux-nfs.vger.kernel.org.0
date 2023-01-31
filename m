Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7868369E
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjAaTcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjAaTcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:32:46 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2138.outbound.protection.outlook.com [40.107.101.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C02E0F5
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2xOEcGSV+sq6agCjZkaSoGyxslOlzXnySH05lv8S94bLpgHZbj6x/5oRKpeDz5/ucIFZkPr3ZykNCBi57vr0WX4W5w6bNZa0V63DbUvaA1vihDfa5MTSkF5Yh6HrLqu9vwaxSzM9mWY18zlwH0dP6oNzDr2tiBo30RKMw16+2sX8nBWEpOtgXKKWyaTjE/2cwVFiyUaiJtTojt5qK9Xw1SArV+q/1SYe1uw2ZFTdq88XIoVTkiY6em4x6l9D2Be/vawA6XBSEQoD0vzIqlgdy6GrbZs8Gy2LYbq+ZdXhP6/1oCLs/f4IuKQEuXQroUJzgTJjZn5uZZ5+yzXT7O3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYkK+b49wDGschwm/REVT33hvB2+FuIf2zHUxBbpNpc=;
 b=lnOcxxV5dBEdIC9+epKCkIbu86wYrSQWxw3lZw0d488TTkwpVqH6DOdvheZWWHpFgF7LKaNUcCtXQQ3swJ+yNhOduwbHty2eZBrfKcz5Ng/SyTSyZhHHAUVHiM/I/iGHh3F8nwHylK70k/3q8/UtI3VsnRQ57SB9lMjhGoF7aSzBlBdBhJIyxuA8IyTrxez5plkjbRJbbcH58alFA1X+mZ//JT2dmJn281x5bSlxDEiKIpYSHG55X1A2r3XLQSGSSC05vXV0OPN2yNYhBEt/3owg+k6ZrRSyy/qbMkADJClQyEOGk8kyeb42v32IeKlsnKU0HgMOszWrIf6X7LfUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYkK+b49wDGschwm/REVT33hvB2+FuIf2zHUxBbpNpc=;
 b=R59kfZQle9JkuLq9KGavbrzKA+XZoNZKhdPhqy0MJMQ+PQDrh3hXRpJ4dFelikhe55U2W0DdyYbWnG9Xv8AJKOyAv+Sf9Iy8TH6vkOOaij/gD5l5KUF3ZXfCqdu3iFeXrPiIN4DqKHSs0IXJ3GlnB9fR8qGoGfqmeVtfzqp9ef+E2GD78Jaf85VhJDflhhwU+10u23OjvBh76wAqPDtkoBI64Qoaz6NHXgui8LcHwv7TTNbypnv3fnlNyZ15gotf3mCzjJhYpoAqdkCxqEICjTOvDbB7VHtk6/1oV+JQ8IFTelG/eG7xB4wsT0QpxUzZk/XDuLmrK4H8d/k0dXuRZA==
Received: from SA1PR09MB7552.namprd09.prod.outlook.com (2603:10b6:806:170::5)
 by MW4PR09MB10187.namprd09.prod.outlook.com (2603:10b6:303:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 19:32:43 +0000
Received: from SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9]) by SA1PR09MB7552.namprd09.prod.outlook.com
 ([fe80::2826:5e6f:8093:45f9%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 19:32:42 +0000
From:   "Andrew J. Romero" <romero@fnal.gov>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfbZsyiVLox/EunGMra5E7rNa64haaAgAATyXCAACB5gIAAAJ1QgAAY44CAAAHUIIAACwaAgAACmOA=
Date:   Tue, 31 Jan 2023 19:32:42 +0000
Message-ID: <SA1PR09MB75522342729588745CBAA834A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
 <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com>
 <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <884655AA-804E-4AD8-8469-04EE3AE75476@oracle.com>
In-Reply-To: <884655AA-804E-4AD8-8469-04EE3AE75476@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR09MB7552:EE_|MW4PR09MB10187:EE_
x-ms-office365-filtering-correlation-id: 21303dfe-6133-4b35-64a3-08db03c1ec21
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkXUGTZVIli7EbP7mUJIgK6ykGrq9BJl3NfHFN6xPESTTovUmMlJW0F0iJM98CmWfVuxcqTXojGm4mSW49Hsc7QuQ45xvn8cNXSaovZhYh8HtCC+60bRUoCsJkNl77fJqOsCr3tWHL8wbZiibwgi7nuxGWYAn7YxvV9xde4/NyQOiZCBVk6jlakPwZW3oULOxINkO6MKIQU2P2y/uwhtJckIhw8Efp9zEycdC5sj1j0rrkKkoVZ4R4BKcEuq9qRstVJh+10GfnE2oMydw14sItECb7ekJ1Cltj6Ss2oOsIohll/ViBqATHbQvP6XVrSCoLMi3XEOPDhPO5Db9PiXntMz4YcUeGXlh/hO+mBHZ7f8jsJw05OVqtEI3oc8eef67fVW6tS3IIBVr83sWbTiP++AR69BnU7UR937UTtEplVLcNZhW0d3nZgx8dfS1BU3QuQEHOMoSdo/MsQXSijPRTzVDQylizfhiHafTGvzCTM8AbWmJsBp47sOMMEi0OqYUSGDPJ574gyfxTMP8/Ed5VXEcD6H89umOfBdJPBXInGLGx/dEs8azUnRANHA5BltBpHwj/uUBJlutmKVXzJ7sE4dCjo9BuF6uksBoS0Ub8rFxMM4F8t9aYUxLmESa7mkPGSf2y/IQbaBe2Cm+xYgPh+rojwF2uRLeI7CA2DRdsMx1Qu9zD0Y99yOqSpYu5aMBhGAWAyCPrwTIMO8evfmOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7552.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(451199018)(8676002)(4326008)(66476007)(66556008)(66446008)(66946007)(6916009)(64756008)(76116006)(71200400001)(54906003)(8936002)(2906002)(52536014)(5660300002)(55016003)(122000001)(38100700002)(6506007)(82960400001)(38070700005)(83380400001)(186003)(26005)(9686003)(33656002)(508600001)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IbO29fi7Wx+u+boyVcXK/t+LQfYNl6SAEwKQ0PGUe7HfmJsqy/FtqvDEZFOx?=
 =?us-ascii?Q?UxoXFuxP+0nLCtXs+WAlwVctLpQjJb+T2vD7Id3YMYJ1euZ1JALLMpN+A/nY?=
 =?us-ascii?Q?VMKuso9hWUGfuIeIxbNrxSQeMw/iNCkgowlY+7ZXyVVYNRMdhOlYheoUe1Se?=
 =?us-ascii?Q?37JSGdaBXVym224+ttREAXt+NwqIDblfDAcVXTSkzRBPf7rwha78Db6uJkDA?=
 =?us-ascii?Q?UW7A94iIr1qiQPUdqw5R2frY2VFrXYIzsFMN5eOmM2A1q0bNKdF1TF0qaA9A?=
 =?us-ascii?Q?dIdMeQILgu1IOC+/gWSVPlD5sakcSME+bfFj3WBMd3LQ6QMwEOQtdwyRo1Ue?=
 =?us-ascii?Q?sOKRTzi4gJ2ya9tBUrDzn4Hn12LNXQn6Z+kHPwcG17DLwmIc6ABVdtmgu4pK?=
 =?us-ascii?Q?/BXNwsFSLEskyNWjkecRGGchc22Ka5vlR+EmOOAQckiHy7wTtqK9XTSOt3Vk?=
 =?us-ascii?Q?FLCW9JzGi9YHbbgeWH1i1kozUt3VP8H1fJTD1jjIGzjipgbz/YXzMXnYc1LS?=
 =?us-ascii?Q?56jl23IbbN0Gtw5+XTakT1W4Xjzay6AUgBDaryXbuzf01jYt1warWR5yVsPn?=
 =?us-ascii?Q?NcOns0SR7q2KkGFDAOZINTYEhyx4Kh46eesT784FtNMETYSRQ79jELEoJJ0S?=
 =?us-ascii?Q?D/QbRwScwcTG0iJKb+IuR9DWlfufDDz17gw6eZjeETCiI4Wuc38gvENRE1Vc?=
 =?us-ascii?Q?x5y6316Un52rigzMZRyTXtNzPA3vijtbtUVT/ss8XYhepfQVjjMHeD5c3VBU?=
 =?us-ascii?Q?MOd4bBmGKxVAWYyfdjwm9PYrBo9V4WEalfaoMVk8n+4BRZOXqUu6fDY05EYc?=
 =?us-ascii?Q?5iQdTYTStNLCQF+xC6F4bBI8HQg0L2jrUWUUtMQTpMwUaMyG2mj9lkmA5TpV?=
 =?us-ascii?Q?9AfZ8WEGB/wXBzDp4Yh+nb4kCoJ4RwihQGWzwypwOUu/NyWsypOY0NAI8nA6?=
 =?us-ascii?Q?6jTBXvl2sYffn9u30246NxD8B6UR7oZZr2nPBe/fMG6JP5hfiCf9brZkFttq?=
 =?us-ascii?Q?gPRhiuFmYyYtowELxg5R138K4l+38EKJPfl2i2S9NAQW10ITpxRyyDWvrvPf?=
 =?us-ascii?Q?HE65aRlId+6JW+TyGtbo33sPVNcIRR+IOExZ2Cw3UAtFT5PExeXHtDQE+kBO?=
 =?us-ascii?Q?H5AJpLJR1YEcc+zSdXaD5COB9wFUmFpN4RuvP0au8Kto3GmY4+wsYp88e+Fq?=
 =?us-ascii?Q?W8sQkkP2EwPxw4nviwJXpOf8EFQdvsA7shngyAyuJoFQ3vG3rJdJoFbmE0nC?=
 =?us-ascii?Q?Gg5M4BtYWgm+lgq4C6gWRxVRV0CpIdEgpkM2BFEWjHzdQrXAJUDMz7W3ApvX?=
 =?us-ascii?Q?VHFglA4yDmzEwivWxN5sN3DhXUdwhSKc4jMqQwTze3M2DMwyXolpSpTb1Mlm?=
 =?us-ascii?Q?hm09NuJvfy7ICK3dPhc9iSuJOuvINsnB+hk1+AssI9RZhEnd2LqJorIMUSJ7?=
 =?us-ascii?Q?GFZlYCjvhsPt1bxV2NKrtWgHMKjU8zc45Rh9NVi7sq4J5ZF73ZRhk0Wp4EQ+?=
 =?us-ascii?Q?kcUSmBrcOIMArRZUeX6v8xj/ep/101ottHkBeUOya1D9TDc4pW+0txgt0lPY?=
 =?us-ascii?Q?vYFHTlNL4CE96Z9wnFlhpww2Glt07Z5cghD67Uux?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7552.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21303dfe-6133-4b35-64a3-08db03c1ec21
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 19:32:42.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB10187
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_GOV_DKIM_AU,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Chuck Lever III <chuck.lever@oracle.com>
>=20
> Almost. The protocol requires:
>=20
> After the client reboots, when it opens its first file, the client
> does a SETCLIENTID or EXCHANGE_ID to establish its lease on the
> server. All OPEN and LOCK state is managed under the umbrella of
> that lease (and that includes all files that client is managing).
> The client keeps the lease alive by renewing the lease every minute.
>=20
> If the client reboots (ie, does a subsequent SETCLIENTID or
> EXCHANGE_ID with a new boot verifier), the server has to purge all
> open file state for that client.
>=20
> If the client fails to renew its lease, the server is free to do
> what it wants -- it can purge the client's lease immediately, or
> it can wait until conflicting opens or locks come from other
> clients and then purge some or all of that client's lease.
>=20
> If the client can't or doesn't CLOSE that file, it will remain
> on the server until the client tells it (implicitly by not
> renewing or explicitly with a fresh ID) that the state is no
> longer needed; or until the server reboots and the client does
> not re-establish the OPEN state.

So , in general, this is true:
  - A lease is not "issued" for every file opened
  - A lease is not "issued" for every user running on an NFS-client host
  - In general. one lease is issued / managed for each NFS-client host
( if this is true,  my server vendor is probably not forgetting to do
  something they should be doing )


> But again, we need some way to confirm exactly how this is
> happening. Can you post your script, or capture client-server
> network traffic while the script does its thing?
>=20

The script is about simple as "hello world":

import sys
import fileinput
import os.path
import re
import time

def main():

   StartID=3Dint(raw_input("Enter Start ID: "))

   TestDir=3Dos.path.normcase('/nashome/r/romero/stuckopentest/dataout')

   FPlist=3D[]

   # open 2000 files and leave them open
   for x in range(StartID, StartID+2000):

      TestFilePath=3Dos.path.join(TestDir, "TestFile-" + str(x))
      print(TestFilePath)

      # open file append file pointer to list
      FPlist.append(open(TestFilePath,"w"))



   # sleep for greater than Krb ticket life time
   # 2000 files will be "stuck open" on the server
   time.sleep(60*60*24)


main()


NOTE:

I don't expect people on this list to debug my issue.

My reason's for posting:

- Determine If my NAS vendor might be accidentally
  not doing something they should be.
  (  I now don't really think this is the case. )


- Determine if this is a known behavior common to all NFS implementations
   ( Linux, ....etc ) and if so have you determine if this is a problem tha=
t should be addressed
   in the spec and the implementations. =20


























