Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CE42C6BC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJMQwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 12:52:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30356 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhJMQwE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 12:52:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DGG7Oo003525;
        Wed, 13 Oct 2021 16:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8S5vjIurdPDS5zioK7GOOZWrW8Vl6VyZL+DLl0ZcVPY=;
 b=JrqmWuTQMVS/SVFPtPuqtmP6otQlMCr9BFW55d478BpSvUkYTsPKvZANoFSf4yz+/ml5
 qsYxpimmtcdD4MGuNIoRad/jW1abL6gxKjEkZdhrcKTKMKwwe/WiQ72FWFxpLDmEx82U
 b/GYRwLUk38LXTL+OndX93uYPaMFnPXURCr6erokydCqLbZFIelD9+E4K03FsPJKzpIm
 OCnxUIvP/GCnGO3qRoqu8yHDoR+iGY0u/2ekjk+xjkclXFuHfumE3Jy52M87+BhR/3Ke
 ghroiWEyYmJo3WS813ZjMiDwH9B7i54v7RFJpDmEFaZUNlCn0WVVz7vQyfDvkMM3CEyv 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbjdqw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:49:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DGVP9C020107;
        Wed, 13 Oct 2021 16:49:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 3bkyvcdv6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6HJV4s1O7GaSB279x0JrFKy/Qhd8QR6++zwwpF7+wmga3A3hM9LodixAyHa6TYz+IGXqqAZoLcVNI1M/ZmLSOp9sjSJzSKUPYrOL+0LRQqOKge4MNXfaptoLqVYuxdke1XP5n1VSIePuErNT4vLBDgU3T5tDMSRxov5Q8clMWC+Bfja/3JhZIyvXuWq/NEBgLOfFYlhFOjr7Hepv/sZFNOB7tpO3LITTwPdIzoMuOLrCfBaRBej6HOZkZCVX7DOmzfk6kIgIpU54Qm3rjYQ6S5fzcGcPYavwGpn9Xq0rLYMNPfbIxJ74N6+WFeXSeyTB6rh4HYuw/VsE8bprxZDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S5vjIurdPDS5zioK7GOOZWrW8Vl6VyZL+DLl0ZcVPY=;
 b=SMpTJ5I3enA91qA0d4UakAPuqVXhY8fwpWihj1kb0FIFvvmTaWS2zjwJZ4t65TlXTPSv21bCIw1LAv6JgFTP4Hwpx4gD14vur9NIjqO8eSxa1RJhxA2FEGaTTAtFcGMH5u5A9sStdngugeQBg2nHIRNOyvIhYX1VIxT1MpxpoYu2I1MPUenkKnb4bd4vpS2/Mh6MXcjuSs+FkqTOMoRscpaxfsT7O5NC9NvimXESbfNkRXD316k0H3VyhjH9DL+eWoxK49u5QrGscbAnsVLnpWgwERrAlYywmHeCiNMqahpVg8SUhUBRNW2tP/6IK3IueqvwYrPoJ7BnybMSMb6q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S5vjIurdPDS5zioK7GOOZWrW8Vl6VyZL+DLl0ZcVPY=;
 b=iOtlU946a9Eix2/EZNqnMWjBQ4AfRDifD6tkHcj8g0t19m2/Uk/GYkQYB0FS79CG8x5W2gXV0cOcgEE8U/Mycrk2WlW7RftJKj2wj0DB5HYAIpds3Ky58A7O/Bu10MdgSzwuFnNMEaACBWklt01gl18g8nLGxvjp2+tIeLXals4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB4086.namprd10.prod.outlook.com (2603:10b6:a03:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:49:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.030; Wed, 13 Oct 2021
 16:49:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Thread-Topic: [PATCH v1 0/6] Deprecate dprintk in svcrdma
Thread-Index: AQHXwEErGl+cqu1kpUWdnKCEhdLzOavRFhUAgAAOGgA=
Date:   Wed, 13 Oct 2021 16:49:55 +0000
Message-ID: <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
 <20211013155926.GC6260@fieldses.org>
In-Reply-To: <20211013155926.GC6260@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be51252f-a637-4c11-f049-08d98e697c58
x-ms-traffictypediagnostic: BYAPR10MB4086:
x-microsoft-antispam-prvs: <BYAPR10MB4086D6703CD1612F1B453D1893B79@BYAPR10MB4086.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CafXvG+PlqjZqJ1xto7f8cMdM3EfhccJ5fe8N3crvTwC1nsIJBHTps2V9MqgEveXaysLHY54x4duMTFcW5UO+JEEyucb63tbElYABydWDbwV1qlrcnGkhdwp+vTUWPtZGKT1WVJpwHH/662J0i2OwPjYwhgDLxRBE9jV/P8CvdoxSgfUaLjCh6LTLvd/lJ5XCMnmvFKqYRd/feJT42t8hDIdJQx29W3YXBwWITjEGWwRGgViVOAkV16yggHUag17m2G1llUhIBP50KPnjXVt3Hr3wgDHLglXHqI5mRlHszZmsVN4/gzh/eW2nJeJ0F5tR2HlQjoIHAbQ2NewRO3V/cbj4it2nf+rh+kyCTeNM63loLoS5kus8zkR3l5J8ETVJgIr6wMXvFDcPWpJyfm+/3K0FhUtqtcq/gM89yHIgNI8xprLNHKkn+wUQSTN4IcDFObVBV+m6EdRRrFB2eUJRNatWe2Cf6PIPDZTqntTX67EP/nvc6pC5V33MPTWiWbgYpy/TmUvillbHCTKF2lfHn+J14xm9cpKLaUBGqfVPE9l5PNOLKgckGH/MpqpI0StDsyc9mJKUML4oSSQ+4v94EbPIf9CgFRuRnZI1vVCZDa71Lw55DxgMuSyOyPRiXMUWJZS0/gjUN5m27ljlLv2k2FbMGXUUTekIVL0z7XzO+6t5U0ZflJlDXd2ud3PkDGyJFjzMQcPBcun2tyieSREeOBbJal8NaLzRMYK0e9PCKEY3/UqcQDdqrZyp1ZaY7uon9K/kLb3UzKNfm3NdDqyYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(64756008)(66446008)(6506007)(5660300002)(66556008)(36756003)(6512007)(53546011)(71200400001)(8936002)(38070700005)(83380400001)(6486002)(26005)(186003)(8676002)(122000001)(2616005)(38100700002)(86362001)(2906002)(66476007)(76116006)(6916009)(33656002)(316002)(91956017)(4326008)(54906003)(66946007)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NmO6EtlEjO/8B09e6JGD23tbiegNj+ovtEiFkECOTYPKXOf1C4xBF5hYnjZu?=
 =?us-ascii?Q?98djRjNMP1SsnYI2Ucl3gZagrEkG9g7MDv2+hZqRIa4+z1vvBc4iv1b9kpIn?=
 =?us-ascii?Q?7cVA7s0eO924d8xz/kOwAg7NuUEQd/vB23PuBtSee3inAoyy1Ht+J+j3jYqF?=
 =?us-ascii?Q?scRmDptdCNNwqWovpre9U7lChjqAq2pTwkFrDWpU861x+UxGqN6J3p1JgTQ/?=
 =?us-ascii?Q?NDlI2l2/E9HY/5daAfxpylXQ36mXHw90MjN16kqJOw2GCFsmQ8JUFsm7lHH3?=
 =?us-ascii?Q?dNkRwItI8HUuv6g1NxMy1jTL/4yrW9eRAwX8N8DGl1BCbmCZagyklNcI0mya?=
 =?us-ascii?Q?wYpMTs5uvp7ZOw57+vW5fwRBWO6YwfYkzo/qY+VXWbMkXQKRO9ppRFZkFeD5?=
 =?us-ascii?Q?s1R6hBmfY5BNWrGuFkwDp25J76svd9rCHr+d4Xqh933d3MTQ3jJDVvJTb8Xk?=
 =?us-ascii?Q?lZHQMeeHhz6vPukH8fhgi/5AvXCJXfdkTj1m02QLCdv3VRVGw8TF12+6ar0t?=
 =?us-ascii?Q?agguklEmjeYHtUGNMZb0I4yHqc0mqvedhnxqKMD356CCeYXpp1k5dEHH2jeB?=
 =?us-ascii?Q?TtZWIvVzsExrC++S9Zi4CM+U1pqRFV+f1u6GPhgEOHyedZrC/Xu0Ttrc7zPt?=
 =?us-ascii?Q?Z9zvGopHKfUP84n/h03Mo9qGtvW/4/ofooA6KWZxYeSvcFm9xqUF2s9BB9UD?=
 =?us-ascii?Q?6yEaTpWnNVPZ4WN+unzmEKr1LwVlAo+QpBF3jVsq+5huaP80v0l635eA54eY?=
 =?us-ascii?Q?Mo70LwWqEn9wnssOOAT3TZiUr7F3PcA08jflEYh/oqTOLDKIPkjfeSCXG5s2?=
 =?us-ascii?Q?UohCeZpM92CD5IX1M7lX6I0/jgk0ejGjBsjkgHt6Y57piT/S2x7Rf1w/e57C?=
 =?us-ascii?Q?01v343Pbvtrfkw4YcYBfSd9+2vGbhn/Jfa/GfaD1Q4Msz5nfZ44uSZZj2sOk?=
 =?us-ascii?Q?yypXd8ldMU1bnqa0ap1YCrqpLcUuaAq1IZF6nhE+zqn7ArrOUlCAJt70lo9D?=
 =?us-ascii?Q?Vm/mSJrQF/kIdvd0YZTXv1wetGOnmArEEWbsSs48bcvA1CHik47CiJYlr3bz?=
 =?us-ascii?Q?9eZfEl7bhoETFPTYWo1iTV8v81nI9wfRIJbXMdmyVoS4Mlj1CkVzQTxp1AnN?=
 =?us-ascii?Q?O0BLGlvcxPVoXJ//ZfuxemuVbiYq23Mf3qoapm181dtcRCAgRpWGzG32n/Fx?=
 =?us-ascii?Q?bQ8n5dLUQbgwRQxzhK0rYoEDYB1XiaTD045GrekcjwWiXTJ8h7SPgHVE+p0K?=
 =?us-ascii?Q?7eAbNWM29nFA6MW7JVG/rEmUx3DnwoeS6W5bvwkFeZSAEvZetTTudIT7bkrv?=
 =?us-ascii?Q?0neqjQRNpA+zsTkZdAaXWA58?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4A6FFDDACB5D747A294E3EDE2D90F9F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be51252f-a637-4c11-f049-08d98e697c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 16:49:55.8111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QH+vgkKQ8Luk6lAGnJaSNAmCA/hfOdSTCvrXCPLJKb2shD2iipNkcpCTIrZCcIfML2CMfk0bBn9Cw0VAlXwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4086
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130104
X-Proofpoint-GUID: X_IXNXRzo05NvEm8tQGWqT0RyXWxPolK
X-Proofpoint-ORIG-GUID: X_IXNXRzo05NvEm8tQGWqT0RyXWxPolK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 13, 2021, at 11:59 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
>> This patch series moves forward with the removal of dprintk in
>> SUNRPC in favor of tracepoints. This is the last step for the
>> svcrdma component.
>=20
> Makes sense to me.
>=20
> I would like some (very short) documentation, somewhere.  Partly just
> for my sake!  I'm not sure exactly what to recommend to bug reporters.
>=20
> I guess=20
>=20
> 	trace-cmd record -e 'sunrpc:*'
> 	trace-cmd report
>=20
> would be a rough substitute for "rpcdebug -m rpc -s all"?

It would, but tracepoints can be enabled one event
at a time. If you're looking for a direct replacement
for a specific rpcdebug invocation, it might be better
to examine the current sunrpc debug facilities and
provide specific command lines to mimic those.

"rpcdebug -vh" gives us:

rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc ca=
che all
nfs        vfs dircache lookupcache pagecache proc xdr file root callback c=
lient mount fscache pnfs pnfs_ld state all
nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcache x=
dr all


If tracepoints are named carefully, we can provide
specific command lines to enable them as groups. So,
for instance, I was thinking rpcdebug might display:

	trace-cmd list | grep svcrdma

to list tracepoints related to server side RDMA, or:

	trace-cmd list | grep svcsock

to show tracepoints related to server side sockets.
Then:

	trace-cmd record -e sunrpc:svcsock\*

enables just the socket-related trace events, which
coincidentally happens to line up with:

	rpcdebug -m rpc -s svcsock


> Do we have a couple examples of issues that could be diagnosed with
> tracepoints?

Anything you can do with dprintk you can do with trace
points. Plus because tracepoints are lower overhead, they
can be enabled and used in production environments,
unlike dprintk.

Also, tracepoints can trigger specific user space actions
when they fire. You could for example set up a tracepoint
in the RPC client that fires when a retransmit timeout
occurs, and it could trigger a script to start tcpdump.


> In the past I don't feel like I've ended up using dprintks
> all that much; somehow they're not usually where I need them.  But maybe
> that's just me.  And maybe as we put more thought into where tracepoints
> should be, they'll get more useful.

> Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
> places to put it.  Though *something* in the man pages would be nice.
> At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
> dprintks.

As I understood the conversation last week, SteveD and
DaveW volunteered to be responsible for changes to
rpcdebug?

So far we haven't had much documentation for dprintk. That
means we are starting more or less from scratch for
explaining observability in the NFS stacks. Free rein, and
all that.

--
Chuck Lever



