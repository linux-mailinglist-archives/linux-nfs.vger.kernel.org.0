Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771D14B2D43
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 20:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiBKTEw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 14:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbiBKTEv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 14:04:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C7CC8
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 11:04:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BHuvoQ023170;
        Fri, 11 Feb 2022 19:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xokpUPHct/aYDsIwmREh35rvFvXQcCqvyt8oio5hdqg=;
 b=BYFF6E7hpv1FMpO59I37Td74vSjCZA30+PWoNBph6+yKj+vkitgNcR2FlFHnGyhTZvos
 viOU6finT08kmvvpQh3xOc2965lcAw7ZUAKmVA11PC7edzElRSiwCwt4j/9HEjqQuOlx
 Z7uX2SC2kqYeIaaK8+hGPqku5zwcO6aV4ZzDrYT+qc6G05RNO8KxDFs/w4UWpu1XWwMA
 31Jm5t+rJnsruXNRJ+xvzbWGb9Debn07j9Uo8Pl8SRi4iToS1I5fiCqRQCGdnh0yu1/3
 ErTKBKPmBvb8DGsWQIqc5XNIuCr0ZFicRrwhm4RYjCwY5L1rLiTaNMSqGcr4edcab0w5 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5pmv94b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 19:04:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BJ207N026010;
        Fri, 11 Feb 2022 19:04:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by userp3030.oracle.com with ESMTP id 3e1ec7wgpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 19:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMvZS4scH1xrurueP5SAgr6X8vCWJkDMBWS9nPHKXzEz+Dt6BlNyG2ZkUhOYJ/dsI4paNWw3hseCBd2W0/jootJAoa0HaqP03doRi9ji8Phnq+FL4mfMsHQXqhEHZ4oTqJMGv5Hvh7smiu7ovMlzVSmNZG7nymieTj1jHmi3Rk1hFq/dNGX/lci9OzrYknq4I6wclHCpmdFjrPPe0QQ1G5KmI+39fJwfVCqrBjLEZABlFtEAZaq+VFpvXM2k2pG4CglsqpaM/HWui7A54b5fA2/vB6juawp2MYU2Op0mm8a5pV2fdOdofXJkikOtr++vfdYbbs2KH1rMQs9nrWYWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xokpUPHct/aYDsIwmREh35rvFvXQcCqvyt8oio5hdqg=;
 b=R/NLH0rBFAWGFSizvIaZRgm72Q/+LGjg9gj9ghXIPFis8QYK8vpvS7D14hZriVb4Km+M6ojP/2XGrhuvHH/hWZm539yqTtyuezDUnhGt7WBllTazhzSAgEyX0TswOcb7nHh51EwnQ9qbbPxfZuzuiLImd3R0wjDrPg1qKI0Y1OPmVuQX8IBGw8HhpjL3xygDAt4QW9wA4DhJTXYpyEhyqE8+K4q41d9xvvjooIJZpp2xpbMU/s4BBs2nSIo42N/z+dvCfFp8Lph/oHN2Penaj/f7GK9J9lPfREtMyVUj1lBUQjdUzFkidgkn4eB66B5wi8TZh4LbhrGa0j6ZoTTHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xokpUPHct/aYDsIwmREh35rvFvXQcCqvyt8oio5hdqg=;
 b=puiU0Ay5Aimd4LaXoRL8VFsrPg1reFtrFfeTJU2MhEL4WmWQlkuE031gEXzHkqNwj0JSOY5qT4wIDAsLUMGw513k76atZsV6ZFrr3IIQhJdOQreolN0sXb8ogLBUlhgqFQF7JB0obWJXnozjCS6u4X3K8GJjVUBYc2D4gPsAM0E=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BYAPR10MB3206.namprd10.prod.outlook.com (2603:10b6:a03:155::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 19:04:43 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 19:04:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Topic: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Thread-Index: AQHYHqhMlT21uFtPcU6l7DrJSxeLtayNFxwAgAFGrYCAACKIAIAALKMAgAAKL4A=
Date:   Fri, 11 Feb 2022 19:04:43 +0000
Message-ID: <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
In-Reply-To: <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92793ade-18d4-4b2f-760e-08d9ed915cf9
x-ms-traffictypediagnostic: BYAPR10MB3206:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3206A0CECEDADC93D3EFE13E93309@BYAPR10MB3206.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEpuPHgmXFUsOwM8oyUbmhbEg0bHjbU7i8s16xmXobBdhFe7vY0VOymTAyiyI7CLMd7GOfkCPfQ/0xYamrDZx4W3MDId36uY4DDm1XlsY3V8gBPLBVNPv3+9aG2W9FOKm11puCsi03sWoc5PRmcOxlanzE8AWY/zNTrxgR4zRO/HEskE+KPCO2RWvEqFteshTTAH2gZKSHFihJWA9st1d7PWj7RQodZu1n/tg/8qYaKKH3AE2H11gj5WwfuFRE9pEdIqLyeku0SvMZ9oW81xF8iWOf+1Cunb3eHVrkuhbWx6/zCr4ie4CcETu3SAReOxAIp9xP8I7kZH1fDXdvPWkVM0G8S3PP3hQrPDa28ItuBCcMwtiOtv0/ItZfzlSTSaJcxg1E5NQ7mpbRzAYVr00DMkH9KeBuqvBgojeoK+4WMEwDxwmAPNKlZilJUoRRxfWQOUFkMkEiCZO2Y9TZOV64hQyd7k7CL+5/qEaE9WFOxviiEj6DMTDjftrfm0LtasXeBdWFs6Ez15r4t/WOC3+aEJje4Sto3lwhfhfFJcVVW3+KsP8j3tllErgZhe8kGzZDBERjzMBd1vYWYRr4IUEUZ0DdKB4GCMFPDTKa41/1phzACbmFlMBXE517+RJcr/OvOR9hr0I+xrZrd7/M/cqbGLlxS8SLfA0yVlfofLJf9RagHiHCNrO/n3dJHho2OigfzoIfSsRAssAgxf/7zPNRlodyj8kbayFa5KMHBHx1eVEuT53xky+UJjch6RIBnC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(26005)(6512007)(64756008)(186003)(38100700002)(8936002)(316002)(71200400001)(76116006)(38070700005)(4326008)(66476007)(122000001)(5660300002)(6486002)(33656002)(66446008)(86362001)(8676002)(36756003)(6916009)(6506007)(53546011)(2616005)(2906002)(508600001)(54906003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqlqVor4udbDIDnWkZZkSoaY3Uxwt893VLy03LuyGWJbK4vqqadYAr0iB4Kc?=
 =?us-ascii?Q?trhdSBrk1X03ZVVkwbtQk8HusxOzqfKxsFCWHiBgDbmdxw52S1hEaNfR+c9w?=
 =?us-ascii?Q?+AvuYk1cBRGpvKpeXVLZF10ks6yw3SmzbwYF0wIgZb9M+27hSIQIUo3Mtr1f?=
 =?us-ascii?Q?hV4iUREplsPsn0qR1wG9lIGYw6/lN1G+sod4IvHxnzTyy+qBypFXfuTFg10/?=
 =?us-ascii?Q?y9ATSnCSmekdX+TF4r/DDyQR1WJRGDlE9PZMDakqmWkZZ9AFFk2jUuA4kCjA?=
 =?us-ascii?Q?wd7IeswqWhBEpKxZ5BiOSeklW2Ov/UHFlefEezmBGOtCOKZ+zm4wc80vF9o4?=
 =?us-ascii?Q?8k0bb7ERdDKs1xbxsz/salIIPzTuThq+gLm5ajmUm26uSBkf9VaCrLe2zKzO?=
 =?us-ascii?Q?arIwi4tQqFN5t0pjRZwgL0MvY6M4McMFRuWWpKfkYqrujUHHTjHjli0qtaul?=
 =?us-ascii?Q?5Wlh67fpEBYid7ofTKbt+ubVZaSVv9N4IjXs/RYE3dEvOmsguzYqUkvR6+oR?=
 =?us-ascii?Q?mTlWT5aNw7Zeb+2CACaQq+6bjruk53N8RsIcRIAwDO04udYHphBkb45bsrCa?=
 =?us-ascii?Q?wqskeslcwHsVXj//JFG8A5xRHyCCCZmNtI/qX1qB4vZKjFw/jRodH4RKyi3D?=
 =?us-ascii?Q?O5QHDORZ2rsJyuhIhI2NsyhTQE63GJIU1zuSa7ZQyrSFHFRoQvn6WFFVoZUa?=
 =?us-ascii?Q?tq9FtMfhPPt90F1yFXPWVC429gI6pxirVdqrRrojGXPy4oCkeBmch6zYxiHk?=
 =?us-ascii?Q?iqraHswAdEWERGRGR/vhzvn7zjVSUawXxs/fkmvwEOnVPihdRAtIhxoC3Wpm?=
 =?us-ascii?Q?FEoZzlztdun0dI7YMTYc/dRDPzcTeH8whuwsY9pmQ0jNH8wilNVhLPo8OR6m?=
 =?us-ascii?Q?8fW8KaQTJCP01Pl0sWsTqtSZlAUjrSTZH2cmGNpS3nrVgHrZ0x9ehkxnaMAD?=
 =?us-ascii?Q?S1K6FqXHQv/gZ4b4zyRUrTPCh4+4cjkT0IWYOhltCibw1iOLD7jaad2xK8F0?=
 =?us-ascii?Q?Lj29kbbRbz/WBADjJqFcsexwDMd5dM5MHfanQ50AJUR98+NxugEg6d+en/KQ?=
 =?us-ascii?Q?UtETbPgkyiY7fbxSF4DcjFrWMKKJ4ovKbNvicMxkRZn1qfqK465F4VNn20b6?=
 =?us-ascii?Q?TODXckb4o5CTnjxN/ssUJxBsXwb4VrMk/Jj0Xbj9lcbuje7tzvtn5iHIqEUm?=
 =?us-ascii?Q?aOSNNCmo8B8yw3zyQaFNvRb2NVBERVBl6rC3gAqETfl7HidzMqN+tYR4+ieN?=
 =?us-ascii?Q?6+rxbg+9zuWuaY47igzSkLtsgoZmKX4IylgFIKFpwIB+hr0yxdk6QcI9WmaY?=
 =?us-ascii?Q?m8NhuJkws7jHc4WSq/JwK4FHBVge/I3Q3AyNXlrE4JdW1B13tQl9+FnUPFrd?=
 =?us-ascii?Q?C1CoNWiwGxIIv8amxHDCnlQOatUIxfBO03mKdYsuKoVt9ZPLT5qvpJDWtq7F?=
 =?us-ascii?Q?cbCZZXVyV/QuVcTC2ko0suvBZG5oIbmNlfowg9Hm+KxBg5XK1F08Yna51z3g?=
 =?us-ascii?Q?CBUplXy+P7DddxHSwNm7NKT1MtnwmBZK69MS43UtQ8TULBSZ41hpTUOpUlRn?=
 =?us-ascii?Q?qRBzcVnnckwlMSgnNTAjBrC32WeDPOSMceFaoc+GD3/70JJH9xgEcBErJKvA?=
 =?us-ascii?Q?AKNnZEzYvNVFbahgQqXuB9I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <066ABE8D29469F4C88726B347E9C2997@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92793ade-18d4-4b2f-760e-08d9ed915cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 19:04:43.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSeuAmT9kF8Nbvzv+BLTKXnJyLQOcijUWHmnoV/Kvb5MlOT3ZXwUnvl6SbPBS/8GtBZYMsKv9XUsGFfRCQwMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110102
X-Proofpoint-GUID: QmYMgN-BlTeNCqBlK1dDlY2i9bfl-S3P
X-Proofpoint-ORIG-GUID: QmYMgN-BlTeNCqBlK1dDlY2i9bfl-S3P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 11, 2022, at 1:28 PM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> On 11 Feb 2022, at 10:48, Chuck Lever III wrote:
>=20
>>> On Feb 11, 2022, at 8:44 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>>>=20
>>> On 2/10/22 1:15 PM, Chuck Lever III wrote:
>>>>> On Feb 10, 2022, at 1:01 PM, Benjamin Coddington <bcodding@redhat.com=
> wrote:
>>>>>=20
>>>>> The nfsuuid program will either create a new UUID from a random sourc=
e or
>>>>> derive it from /etc/machine-id, else it returns a UUID that has alrea=
dy
>>>>> been written to /etc/nfsuuid or the file specified.  This small,
>>>>> lightweight tool is suitable for execution by systemd-udev in rules t=
o
>>>>> populate the nfs4 client uniquifier.
>>>> I like everything but the name. Without context, even if
>>>> I read NFS protocol specifications, I have no idea what
>>>> "nfsuuid" does.
>>> man nfsuuid :-)
>>=20
>> Any time an administrator has to stop to read documentation
>> is an unnecessary interruption in their flow of attention.
>> It wastes their time.
>>=20
>>=20
>>>> Possible alternatives:
>>>> nfshostuniquifier
>>>> nfsuniquehost
>>>> nfshostuuid
>>> I'm good with the name... short sweet and easy to type.
>>=20
>> I'll happily keep it short so it is readable and does not
>> unnecessarily inflate the length of a line in a bash script.
>> But almost no-one will ever type this command. Especially
>> if they don't have to find its man page ;-p
>>=20
>> My last serious offers: nfsmachineid nfshostid
>>=20
>> I strongly prefer not having uuid in the name. A UUID is
>> essentially a data type, it does not explain the purpose of
>> the content.
>=20
> How do you feel about these suggestions being misleading since the output=
 is
> not the nfs client's id?  Should we put that information in the man page?
> Do sysadmins need to know that the output of this command is (if it is ev=
en
> used at all) merely possibility of being a part of the client's id, the
> other parts come from other places in the system: the hostname and possib=
ly
> the ip address?  That's my worry.

Yes. We're not using the output of the tool for anything
else. At the very least the man page should explain the
proposed client ID usage as an EXAMPLE with an explanation.

But honestly, I haven't seen any use case that requires
this exact functionality. Can you explain why you believe
there needs to be extra generality? (that's been one of
the main reasons I object to "nfsuuid" -- what else can
this tool be used for?)


> If we name it nfsmachineid or nfshostid,
> do you feel like we ought to have it do the much more complicated job of
> accurately outputting the actual client id?

It could do that, but the part that the kernel struggles
with is the uniquifier part. That is the part that _has_
to be done in user space (because that's the part that
requires persistence). The rest of the nfs_client_id4
argument can be formed in the kernel.


> Right now nfsuuid outputs uuids (or whatever was previously stored, up to=
 64
> chars).

Right. It can output anything, not just a UUID. It will
output whatever is in the special file. If the content
of that file is a random string, what will nfsuuid output?

If someone runs nfsuuid expecting a UUID and gets the
random crap that was previously stored in the persistence
file, wouldn't that be surprising?

Precisely because it has the ability to output whatever
is in the persistence file, and that file does not have
to contain a UUID, that makes this tool not "nfsuuid".


> It generates uuids, like uuidgen.  Without something external to
> itself (a udev rule, for example), it doesn't have any relationship to an
> NFS client's id.  It could plausably be used in the future for other part=
s
> of NFS to generate persitent uuids.  The only reason we don't just use
> `uuidgen` is that we want to wrap it with some persistence.  A would a na=
me
> like stickyuuid be better?

No: a UUID is a data type. Would you call the tool
nfsunsignedint if we stored the ino of the net namespace
instead?

Do you have any other specific use cases for an nfsuuid
tool today? If you do, then you have a platform for more
generality. If not, then there really isn't any other
purpose for this tool. It is a single-tasker, and we
shouldn't treat it otherwise.


--
Chuck Lever



