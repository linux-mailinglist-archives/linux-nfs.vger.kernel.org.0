Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267B5BD111
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiISPcV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiISPb7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 11:31:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29347386A6
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 08:31:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDODRP024818;
        Mon, 19 Sep 2022 15:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DpZpedJx6OBiyCVjCvXESL4pZ9dTz+WCBxJqSVOP7DY=;
 b=fvZ5lf5YwT4l9J0mxOlxLa6+iQO5AuL1M9RvtvL+iTiPvOzuoebqmy/4Ih21gpp0T9HF
 sQFMONmsRpbCXyYnHXU6DI4Za/pFFi1TQCijqSCUjmsgk2gwupajOTammRfHQKJqUa9M
 CC+YdPYNAWaedwQLwPe84ckJAQOhSPIpJB6rUNpug6PFBYcssVwLj7NwhW5UFkxunj3s
 FVs9TUaHk49KE/OydCxnTF6ljXG5SumbzRUHHxB4PaXQDwkT6GtoMce2eYrodN8NCO6t
 b0S/cqRDDUKjCuiepw7CPiuV+/zvKG1RaW0pFI8gHgyDG09LOk7sriy3n1juuO+Q1agB cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stc8gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:31:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JEUJVp035928;
        Mon, 19 Sep 2022 15:31:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39j4g9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 15:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrZlzJVx/2RlWY6zXZ+wU0mXBAKwr8PcTKbU4Rql1QgLYDdK7tln/wTzpvPDytJf7O03M5BMVQJgLP9fpUMeTZJYNKGfmzMlqfI0FhRVRDeBKEY+xqY0DsI+Tl8YW9Q/GI/JRY1RH52fBpxWPxHH4BEqQc9vHTMm1T1zA2kvf2mNRGu0Z2/KUfSt4jzZuR5OVzBhuc3HLMRhJatrmAc67XjKVtns15OtVCroOPzQkWlYJ19LehFm15PzA8DgmV/NqCYFL5Py/coZh5z58M82F1DxZjz766MQKdLoae6n/HYdFoRdqfoR5wAis6+hEMBZiJ+LVJr3aW1b49IMRNzVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpZpedJx6OBiyCVjCvXESL4pZ9dTz+WCBxJqSVOP7DY=;
 b=ZwEHFaqZPaUA4AQcDzY5RgQ2yRkvs9pazeT2BIJn7NifH3Y/nq3YJccEkl7r9liE1tZqez5rWT0rVIC3p92iUK4bqx62hN0ueQ+rncwgGtEFCbJn7eCQdogc78Qij/qs+sJ0Px441DLnhWR29y1O2GlNcPqe/6nm/6QBATMik+UbPvFrK8n2XPzO5z87zPDMxL3ba6q19E+OPxfJFSBt45Zpt3J5Y33BisvdKmH9qngi/T2bA858ONgdFhAOoNlPFd+6+GCPU2ENMiJYVtyA7dl2WOA0WA0E3v1XNgZlaUQOEIPKAooxLoWS/Ca40P5HgkX8BHUmgxy+6mzCkbRN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpZpedJx6OBiyCVjCvXESL4pZ9dTz+WCBxJqSVOP7DY=;
 b=uvNlRMa+PwARFSiJyQfF7VWtxzZQOlZCnf3cUFNDDtN/ZdMGZsgimlbfHlUM5YU7vmptc92ewdNlZ56OT8ILnIr/3I35lTEqc06z0geBZNsqVnSZb4qc7gbzLZngDGYgR0vDSNlu4xd0tu9e+FZcBmV3IqBFJIekWXQ7UOGEXgA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5690.namprd10.prod.outlook.com (2603:10b6:303:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 15:31:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:31:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     Steve Dickson <SteveD@redhat.com>
Subject: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDzsbeh4Wv/4SkKDzJtBHUqbVw==
Date:   Mon, 19 Sep 2022 15:31:44 +0000
Message-ID: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5690:EE_
x-ms-office365-filtering-correlation-id: b6771c12-35c5-4dc1-4561-08da9a540f20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9YoZPZvou7HCZo6uDBK4/EdTh4uuqAwAMDezHk4/k2cNJZGRWeqQIC0mFyX+TeYpK1y3idwXr3lh3o+Dy0ZajMmQXP+4XFDMLVmhlM1VaCdKyIP58FedOgmQzuSONG4W5aWUOM79HFuNAbOS0asVOVEEWlZKnPA7BGHZaF4VQxZLbfeH1pTIqceAsyQVOGpWXXyFKKPICvDh3+sZEPY+MUNJrhP6W7xy3aTDuJe8Sqbwet7WdjkPCVOVqbL4unVrYrCrGbAfaVhn56OSScraYF3asfCOnVT3Wco1LRwI68W5DhOaEkZOETnDb1ven8oMlRk2IiGKAG0eDXb+u7XN9MfzBxp9kU9ECRCvcnyGmoJfOicldnXBuf0tENNjmv4gJfHblFUDf6Ea083Ys7UllBoCSx5ZPYOW4rlN6zJ8tegOoHqjcZAjVsqbt1XG/Pws1ByNFYtX1wvC8C4Ntwv7t6mddqJaNb1mUEYw6enchihS8es838pOLEHt1nT0ljB1ndeONXusdM0ThXHujZT7yoCTMfVmBo2a5H5ysRaMIkY6D7iDmwjf5SCQ8j4SP0TGKyXZMn7aSsGMn24fs5G/b552fmGzzmA64cqgJ94CU2AorEP6lgVDyoDS/RoyJVOKH234LTtbbFXGwJCIvga38xz5GdWdHwOBNpI5mbuj5KCOO8hJh613wlMbjScXXPEfztuu4WKlm00eZ/sfT4SppFEV/CyzNymD671+e4RYIoS55IF0w2y66Ig4AEAG5nS45qCY7Tp70QM/NzSXNqpTVBPQQBV4eQnY4D1Yst/3iU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(36756003)(33656002)(2906002)(8936002)(66899012)(86362001)(76116006)(122000001)(38070700005)(66446008)(83380400001)(6506007)(71200400001)(6512007)(6486002)(2616005)(186003)(26005)(66476007)(91956017)(64756008)(5660300002)(4326008)(478600001)(38100700002)(66556008)(66946007)(8676002)(316002)(6916009)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHt4tsmbDWDyCwDHV5uCUi1Kh/kzd45lfSdYLJwasd5zOijw4FNbzV3YatZh?=
 =?us-ascii?Q?EfWxVRrp8fjLj2AFiSGOgomuD8Yikx0GMTblikG/8jnF9SSG+8u0zcRnbX6U?=
 =?us-ascii?Q?MB1V/c+dTn13MCBfSHIcYO8rnjDcD+ydRyScgAbzELe9BIzeumy0HM0hmUhF?=
 =?us-ascii?Q?oqsGKBwxGzK7suU5kZOaVWkPDW4wJXBlJ9+Hl/OfJRZdsP/LYJgI3mnoz6th?=
 =?us-ascii?Q?iWrRMdtGLUQzc/Q9Uvxqdvaora5UIXGoYK1oTA9dhezu6uiKN0KkCEaHSJN1?=
 =?us-ascii?Q?Xl3ME5DZVVfpMK2BTz93a6Mp5+jamV1jnytIOMfKYZvJ8VQrKCBeR+yv4+I5?=
 =?us-ascii?Q?3jMNghdL/cIo+GBbXnOktxMmAmFqxBaEKM2eiutgq8yQUP4KiYGa+wvegxxB?=
 =?us-ascii?Q?0SqL8v1X+Gy1gyIuh+haPKBziVY/g4AIOjDYvilKSRw+7KfX3M+cjKoOZWpx?=
 =?us-ascii?Q?1QnP9dJAhtLU1pBcrxJJCa8WXuXsa/I60lZWm4UCRN5TXnQLfZyMYfC3d5NP?=
 =?us-ascii?Q?mKKW0NponF/CVB97ZZovRG4l1czhFLUwMNISTR4r9YD15glA4NKB3FocaNaK?=
 =?us-ascii?Q?w2naIFQ81K4wlrvNvumNGHSmj5CcURgrvoGaZD3HI6DuecnPuaPNJfBhi993?=
 =?us-ascii?Q?7ak1kXzzJXzKDR6KjiEhBBFXsX8CMsB5kbmaMCsj6L1t/htcUiaCx9DbRfq4?=
 =?us-ascii?Q?H0YdNchq95il/ahO+D35refbqg3/EQTxuakmmixSkUnGiqoKZVmjEhL2Lt46?=
 =?us-ascii?Q?BNnshb0Gzvfj3mku4oAH5xC2ZuUGRi43VHUjH4FqNHgfL+Us5CGC//o103Dr?=
 =?us-ascii?Q?vpp/tqho+FUcjOauWYRm8AFTmqFrjnnmC6Glus2UZt/mD+k6rv3NsayUCQg/?=
 =?us-ascii?Q?FnbGx91uplxaaRY7cBN5nYrUx6Bv7eCFKy2JFDzw3CslF/Mapun8slsZ6KDl?=
 =?us-ascii?Q?KMG2BR044ewYnONnM3ALeWx7ON8wfLIJgS6rIvzofkEhardRQYALcz7MNmL9?=
 =?us-ascii?Q?zOLBXN1NTY5Upqq1KpMGXWvt7nOryfAP0B4BbUAC5WKwXsfTBB2TsA38EUZf?=
 =?us-ascii?Q?xLn7Few46YFG+jz3YP4qPcM8i0dr3hVQuME9778OeJN2qV9b2aMBSXs6rpeq?=
 =?us-ascii?Q?85x4XLlwubXqMFUUJ2AqVAjzmvDkhlCqjdiYgmiH7WrwMwtwmHXDafrNItdg?=
 =?us-ascii?Q?vdWJKSaiDrM2L472WceeHhiC1zNfQiqQihVHnHYd4WrCVRyz5HRWOqO8pJme?=
 =?us-ascii?Q?473DjFw/S3r2Csvv4xp8sUK/vpt62scAQOs3vcCVpp1cZapyogD7Ml59loQP?=
 =?us-ascii?Q?ENFzsRDcznLrm4VWwWAmyXcaqrYp4XZKqUNS680hMwbcltREoXtnzWd2C+uj?=
 =?us-ascii?Q?DtjEH1C0URjGScmglAU4YxPinYu3iuy/5B7P6/6XJkTQFdhIosDX4FDCuevi?=
 =?us-ascii?Q?BJqM9LiNanVWvq2GfsTDFTFmH4xQo8zRhExOp7BNB27Rj/U1Fbh1bDp7XgTY?=
 =?us-ascii?Q?I7WcHBMB3xDsHqPAX1MpCQt9x6UGTk+TCKUZBV9JfcCTJCjPkyhtIS6HriaU?=
 =?us-ascii?Q?ZiZmG/gMDBjTapWZ1pXnaKT2LQkC8w8dLSPz5X2O8STaBKH0DCsmjGa/fqBP?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3155FEBE1316594484ECA1C171C6AA07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6771c12-35c5-4dc1-4561-08da9a540f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 15:31:44.7581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3wDYxQ90o2an4MMIprZ+f8g82fa9eW4N4ual9QhtNC1Uui+vIcAyKsK6lR/e3GK7MbA8UxZxmoMqQHwcvF5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190104
X-Proofpoint-GUID: h9ep4a_QLXiJcd-U7u4-0nP70-FK5rhq
X-Proofpoint-ORIG-GUID: h9ep4a_QLXiJcd-U7u4-0nP70-FK5rhq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I rediscovered recently that NFSv4.0 with Kerberos does not work on
multi-homed hosts. This is true even with sec=3Dsys because the client
attempts to establish a GSS context when there is a keytab present.

Basically my test environment has to work for sec=3Dsys and sec=3Dkrb*
and for all NFS versions and minor versions. Thus I keep a keytab
on it.

Now, I have three network interfaces on my client: one RoCE, one
IB, and one GbE. They are each on their own subnet and each has
a unique hostname (that varies in the domain part).

But mounting one of my IB or RoCE test servers with NFSv4.0 results
in the infamous "NFSv4: Invalid callback credential" message. The
client always uses the principal for GbE interface.

This was working at one point, but seems to have devolved over time.


Here are some of the problems I found:

1. The kernel always asks for service=3D* .

If your system's keytab has only "nfs" service principals in it,
that should be OK. If it has a "host" principal in it, that's
going to be the first one that gssd picks up.

NFSv4.0 callback does not work with a host@ acceptor -- it wants
nfs@.

There are two possible workarounds:

a. Remove all but the nfs@ keys from your system's keytab.

b. Modify the kernel to use "service=3Dnfs" in the upcall.

I favor b. The NFS specifications do not appear to require it,
but they suggest that an "nfs@" principal is always to be used
for protecting NFS with GSS.

But more importantly, other subsystems share the keytab with
NFS. They might want a root@ or host@ key in there too, and
that will break NFSv4.0.


2. nsswitch.conf::hosts now has a "myhostname" service, and it's
placed before the "resolve" service by default.

I enabled systemd-resolved on my systems, to be part of the future.
Yeah, I know, right?

Now, a DNS query for the hostname associated with any of my system's
IP addresses (and there are several) always resolves to the One True
hostname. So gssd always gets the wrong principal when mounting via
alternate network interfaces.

Moving "myhostname" after "resolve" seems to address this issue, but
I'm told that this will be reverted if I reconfigure the resolver or
update the system?

The bugs I found that document this issue keep getting closed because
they target a specific Fedora version which always gets EOL'd after
a year.


3. gssproxy gets the acceptor name wrong.

It has the same problem as in 2, even with the nsswitch.conf
workaround in place. So gssproxy returns the same principal for every
network interface on the system, and that breaks NFSv4.0 callback.

Note also that adding "use-gss-proxy=3D0" to /etc/nfs.conf does not
appear to disable gssproxy. I had to boot up and then "sudo systemctl
stop gssproxy" and even then, the kernel still tries to make upcalls
to it.

I noticed that setting the gssd debugging options in /etc/nfs.conf
also has no effect. I had to edit the gssd service files to get
debugging information

I'm not sure how to fix this one -- I'd like to see gssproxy
fixed to deal with this correctly, but also whatever reads
/etc/nfs.conf needs to get fixed so that the gssd settings in
that file are observed.


Any opinions or guidance appreciated, especially from maintainers
(like, aw hell naw, or yep that's broken, send a patch).


--
Chuck Lever



