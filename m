Return-Path: <linux-nfs+bounces-1129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6F82F007
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 14:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F152285ABF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 13:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD31BDCC;
	Tue, 16 Jan 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachivantara.com header.i=@hitachivantara.com header.b="HUjWRx7l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2096.outbound.protection.outlook.com [40.107.96.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631391BC43
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachivantara.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hitachivantara.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAMJ9hj0EfGEuu5/md3esmaCM0QUhiwlrTZmosihLMW8ClM7GRPG+BATMbuTPGx5MYs8lcQK5+SQK++lRCZRln61i3KTatvXr5aZ5TukDqFwErHPjAoSBUa3i+U2/qP9mm+0nCsS4PpuZFbxyVMD4Om7zTBU1hAX0QHUZl1lKYAwy+VGXI1VaaBG9vFVZFW1v4QIr/PotMsv4xIES43xnl/jvVfeVBjy+YkziqgOCI80JNjxz/hR0ln5+d853dF599aRUsHg+4/91B664FGcXDlA32J+tDJSX/DUu1KYZwD//3KS8Tcfcg3FJNcd8vs7+d8dC9lwqdwgEkcPmaAnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J0gxy+a/Am0/7DRgW3I5nP8dMTwYY9SfsGm7uaVw+s=;
 b=XZHb8+B4rPc4DOpAcNaa5wvMfbeiqgBQ+ECHEy6/f2sQDw5w37XXPjqOFP/HX74kH1LX54sm39EnP99EIbTdDrj5Q1AWl2c3Y1mBliPFCGX6QgC4pcMU/0UZO5I3lRoz+6N2ZGTyovt0P/uao1/aYbwqTfOG6WBKbIvir3QYEhU9pfRcRA4FdHWy1Uh6gpqBaCrv3w+qadXIuqlfTnNGT3ulKSCQv5j0gDOPjzl+MB6SHeTUk31uF8eAlFf8kntT2VafAKSX8QrMCMiqUGqnk2zBByvnrY03wnHDe5S0mi28YF7NEqgKF2bM5tgXviwjwE+JRIFvNV+EpCf4ayWidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachivantara.com; dmarc=pass action=none
 header.from=hitachivantara.com; dkim=pass header.d=hitachivantara.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachivantara.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J0gxy+a/Am0/7DRgW3I5nP8dMTwYY9SfsGm7uaVw+s=;
 b=HUjWRx7lFx95AA56tnpw1eDkMtfBGfJfwtkucFVCnOPpmXCdgHItcmz1ByYU3C5QlUmDIwLaKPF8t6nKYBrUdo3QJONuSWgn9w/+sVgr9LBR2/j8ab/k5EY4K76O4pN6OcKkyeOe1Iz6oKL7TxI3O+uCVKQjkTbYU8jug9BscAqnXgl4dV8Bm4L/XItCF9GxXWzWSugZ5xz7pJeoB3vQh/kLCISD22iype0H6IWyhtA5QsRRJews1/3LHMtRrU3fKsIzdcwJabC9jBKqJCxCTOJ24xoXNXVLzfyvJLcwcx313VbwhmXWsr6RGqKGmLKZ2mmbbwbrII/BztSvIliMGg==
Received: from DM8PR08MB7288.namprd08.prod.outlook.com (2603:10b6:8:23::13) by
 SN4PR0801MB7760.namprd08.prod.outlook.com (2603:10b6:806:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17; Tue, 16 Jan
 2024 13:52:13 +0000
Received: from DM8PR08MB7288.namprd08.prod.outlook.com
 ([fe80::2b41:a5f5:7df0:1a60]) by DM8PR08MB7288.namprd08.prod.outlook.com
 ([fe80::2b41:a5f5:7df0:1a60%7]) with mapi id 15.20.7202.017; Tue, 16 Jan 2024
 13:52:12 +0000
From: Connor Smith <connor.smith@hitachivantara.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Topic: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Index: AdpIgOxAPAgULydbT7evjuyQgxyM6g==
Date: Tue, 16 Jan 2024 13:52:12 +0000
Message-ID:
 <DM8PR08MB72883F3D2AF2A0638CD41356E8732@DM8PR08MB7288.namprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachivantara.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR08MB7288:EE_|SN4PR0801MB7760:EE_
x-ms-office365-filtering-correlation-id: 785f20e6-e8b5-48c2-423a-08dc169a5720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7U0bTYnqiGCpBpEFUKi8rQmCw1SOpS6fIVmOKdQcV85GGVaujvCWGHSi2SYcnBrTSpDdJLScPRJkItJACMB78rzr2NzHJxc9DWPc0lwnSlMEMHEtikdQEhey1MNVK/o9f/r5NBSt+BsR6zu923axu30RvuKkCnaWf7OGzEwhHNV3rGjE/TWqnYuymkXZlHOnGMoJAFUa2jsA6UWeZhlvxYw4S8+Gob4jHqA6TyduUn7d4OrPEnSKV8u2pGXpZLmcshP6f7G58X50rj5ReDIxbcUp2XOl3W+tS6SivXAK2ehsq5miKDnBp7ZEyHce7y+qwssv3MGCGwaoummRhu9uDNshPB0rZ3lVDxFiYY/Uer6u30+zab5TlPeX2Oxqnd4B8isu59wD8jVlQcBSQ/xyWgj2b0c6QIIhBQAt+gKgCka/bvutmWG5rIQwfCIHOMF6JzvcwHSyQ9Cd0HewKU54VeoSpZRbDWayTJrwlUQ2x3oNKrYIxkdzkt4yUla3Xw8UoKJzJShAXa5s97sQR1UW4vuEmE/baJHBjPof8fj7tXkJ5G9TB+Hsn5BLc1xrazN4VTmLWTUr4chLhHAAG06CLqMGsJtevEDjeHkc7mqmEgLmnxKgyyd17F5934SAwvN2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR08MB7288.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(83380400001)(33656002)(38070700009)(86362001)(82960400001)(76116006)(8676002)(52536014)(8936002)(15650500001)(5660300002)(71200400001)(44832011)(26005)(7696005)(38100700002)(122000001)(66946007)(64756008)(66476007)(6916009)(66556008)(316002)(66446008)(41300700001)(2906002)(478600001)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OJSbC4qIjttTAlmdFlBWaIGn8GXvrirknMvepmpOjZ+iblwjKqxrXPYVj/69?=
 =?us-ascii?Q?nTCr/2y7fb1XwULsaqw2iZIPoCLm5gmxTiehykpcAN1a45RGZNNvLyct3Mpn?=
 =?us-ascii?Q?/xi6+kCFdMl4LNnXVsIWDDHmbNd7HOL7yIGS5oAsmH/QU6dZanfoKL4qNHph?=
 =?us-ascii?Q?31xL8C652j4qIzPnoadKafSl7KFmY9iy9TlmpeRM5bQAmpuHJVxi1K7n/S5K?=
 =?us-ascii?Q?PEORrkrRpE54iEeD2mcNxtCjsEvIkhyOQiJJ4NuBtOKKGMhh5jh3wAxYxl0g?=
 =?us-ascii?Q?3pz/HbE1DUJ+ixFHrfPoZDZxYmy5dKmXYijKEfZAygUqKYJo+SSBCgwX0k4r?=
 =?us-ascii?Q?hAA4iRODkq8KcVUgmIeXmv2R+nPUky1eJIOiFO9JmV0eCUntLOxLfZvINbrI?=
 =?us-ascii?Q?PJXoWOVWapuwyd3XLiPPN9k8ApP6q9nVl+NPyNdhixt9COWtv3IOrvoxDvm7?=
 =?us-ascii?Q?7pwszs/bvZ1yC7ojSKXVfknDbM6q3SsMow3QZQmflOm4dGLlJ6J1UkLXI5DY?=
 =?us-ascii?Q?nb/4O1ASm8ImMjSse7mQxhZPWFYOypb+nK13qU6hiWLxA8KK0xGrXvzPgo+F?=
 =?us-ascii?Q?TiIOLw1rdo2DCcxLd+EIIPyzzJvXFkG/YFts6AYiwknANgmFFNK02kdGiQxd?=
 =?us-ascii?Q?6uU+ip9LgOzX6EBsT+rB5kFcwijqFqg+Gz/B20AIOPYXtuq8yIoVIGP38uN5?=
 =?us-ascii?Q?j5fue/me0Y/M/eu9zwBAi4MfNTKN4I0gLpP4uWA3giphonq6yNLhN7lGRliu?=
 =?us-ascii?Q?BpRWTeTYG++tY99/bjiQ2MUG8tNsmbICzueFayYFQnW4V4XJsHmlR2Lx/e8D?=
 =?us-ascii?Q?i9eAbllbfCBAuyRSzjD+/wjkoyqf1nE9/n5ghd8OEG6JVC8JG3oox/aQV150?=
 =?us-ascii?Q?mEAR2LchTFsh5n91d2RpB5peoh2oOP2XmpYwCgkeCZD/2sqp7tb2Z+5n45+r?=
 =?us-ascii?Q?vsn9FA3Ogyfw/90oJUDHjtPDriM6s5Xqcd7K5AZo33pZSaFSN7+lB01ExL7m?=
 =?us-ascii?Q?Q9sCWbRownu6LK2Xojs0bQsUifwMHCMaGHexqvfSekgOIB30zwJCO0exi9UC?=
 =?us-ascii?Q?lfCnS6eiszQFkrh7WNC+zlbZDAAbT694pBvgE9RsrMlfjZ5mMKB3AlahDSg/?=
 =?us-ascii?Q?Z0gPwDMBfM0cDUDe5V193UmaRMhl2TdBXZtPIyQIpidcI4ibHjFc0HAFgj4j?=
 =?us-ascii?Q?TWmf9s63YCm6A2jkFPQlxfwv7JD6nqVzvDyYD9Ctx5/krUHZGk+2jat3U5EE?=
 =?us-ascii?Q?RFIA7pNePyLKOxkqCEpp4VqGtNthdsljDLNGDN1IygEKSWqCRSSzdKnhNHl4?=
 =?us-ascii?Q?XUdD5j0NZCvVGyskh2HYiyPSp58xAuwCG9P+/WPy4I2oj9YNOgpsejhb1A+K?=
 =?us-ascii?Q?qR3ZotcQOnIK+odLVHhahGZFxtOwhNPsSELmuyD3dNlJpAXjmHV+PxKqM2WM?=
 =?us-ascii?Q?HGP89pOslep96EPV29bqzcDekWbDh0b1UcMIBl2N7t35bDde6h3jLQh+icqB?=
 =?us-ascii?Q?GBOreV7E1irQaV05vOaZp0mRAJByl14A7QYC+YBms5LF1qG29bl0DzlDXp4k?=
 =?us-ascii?Q?CRVGxxCULacH0bk08L2G4MSZaU/F8lccCS4dSL7PUOo47UZMedQDHGSNgOcx?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachivantara.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR08MB7288.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785f20e6-e8b5-48c2-423a-08dc169a5720
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 13:52:12.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18791e17-6159-4f52-a8d4-de814ca8284a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2M2vEnyfFF3nevVU58C+YQIVP2BsjLAvbfKDCplSpvNfB4axoA7Y0zuuCcNy4o9oihTH18U0YuLG5UfuOnXbqzNnLpALxcGMKI0gNSuOACY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7760

Hi,

I noticed what I think might be a discrepancy in the way Linux nfs and nfsd=
 manage CREATE_SESSION reply cache sequence IDs.

In fs/nfs/nfs4proc.c (_nfs4_proc_create_session), the seqid looks to be inc=
remented so long as the status is not one of NFS4ERR_STALE_CLIENTID, NFS4ER=
R_DELAY, or an RPC timeout. This is mostly due to:

commit b519d408ea32040b1c7e10b155a3ee9a36660947
Author: Trond Myklebust <trond.myklebust@primarydata.com>
Date:   Sun Sep 11 14:50:01 2016 -0400

    NFSv4.1: Fix the CREATE_SESSION slot number accounting

    Ensure that we conform to the algorithm described in RFC5661, section
    18.36.4 for when to bump the sequence id. In essence we do it for all
    cases except when the RPC call timed out, or in case of the server retu=
rning
    NFS4ERR_DELAY or NFS4ERR_STALE_CLIENTID.

(Note that the comment /* Increment the clientid slot sequence id */ not be=
ing moved in the above commit has, I think, left it in the wrong place.)

Meanwhile, in fs/nfsd/nfs4state.c (nfsd4_create_session), the seqid looks t=
o be incremented only when the session has been successfully created and th=
e status will be NFS4_OK. This is mostly due to:=20

commit 86c3e16cc7aace4d1143952813b6cc2a80c51295
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Sat Oct 2 17:04:00 2010 -0400

    nfsd4: confirm only on succesful create_session

    Following rfc 5661, section 18.36.4: "If the session is not successfull=
y
    created, then no changes are made to any client records on the server."
    We shouldn't be confirming or incrementing the sequence id in this case=
.

My reading of RFC8881 18.36.4 suggests that the former is correct - after t=
he sequence ID has been processed in phase 2...

> [...] the CREATE_SESSION processing goes to the next phase. A subsequent =
new CREATE_SESSION call over the same client ID MUST use a csa_sequenceid t=
hat is one greater than the sequence ID in the slot.

Client ID confirmation is in phase 3, for example, and returns NFS4ERR_CLID=
_INUSE. Since this is after phase 2, the sequence ID should be incremented =
on that error code. My understanding is that a "client record" refers speci=
fically to the 5-tuple described in 18.35.4, which does not include the CRE=
ATE_SESSION reply cache, so although I think the latter commit was right to=
 move the confirmation of the client record, I'm not sure about the increme=
nting of the sequence ID.

Apologies if I'm mistaken about something here, but I was confused by what =
looked to me like a difference in 'slot number accounting'.

Thanks,
Connor

