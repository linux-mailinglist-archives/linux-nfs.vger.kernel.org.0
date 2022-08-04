Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CF58A06C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiHDSW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDSW4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 14:22:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F50929CA3
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 11:22:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274HbQ5V015016;
        Thu, 4 Aug 2022 18:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eNq3uDLP8piF8OmUYVfbVJqrCGO6YjK/NBFDBdiHIM4=;
 b=E+frb5drFpOoL0Zs4QuCpxhSZUcZ7fEKa+6JVb96KAmDX4gRsyvC9AeTQ2dwdCaqHScB
 qXq8eDOZsEldHVRznU9H5ZvItXxWFBqAobuluu/NNFqSNrlYsdQ8xUZzweDIaJulH8zF
 IH82IUWLdzA/U2bJl3ClQaVwi7AeO63B4aCt4k2AF61pgKMrETFjCzCf9GBclMtPrLcD
 776KDDmzq3Q8+la4d9ndeco8dNgLeyqcE/3vZcM+ZjWHGeW1qz5oOs1e3GkapIyawb31
 KdaG/P68RMFT76jESbbW3K9uo/H+OSJL+U7BlsAqfa7FdAbyZyfe+VH+43MzBlvzzIZZ vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2cdfh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 18:22:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274G6LAL031487;
        Thu, 4 Aug 2022 18:22:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34jprc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 18:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lblG2917oF1bK7qq9auauWfZrBVF3DgsJZkRooUOuT+Pgsaarn1ufbNzPQYzzx/8Yj+AXFLrPj3Ob8bB0o/mVjLfx+69DRWZwFpxtd3VQdqBuoO+sWYMF8HEVRcubX9EucniKYicX//REkBxugSJzPhiKzlHMj8q28T55k8UENpebtgm0wNoQduYUh3mbUjeppl4V2LZZkc41/rXVwgWF8/Nz5Wc8yc0qd/wCgp3JNTvlDxj0xKvbD/1hB5lTwUvuQWog958xBmyYHjYZf2wGlISwTMohfWOAQYctZsOy1sH31+0FosIAZSeadj29pd52FIvKT8O9kouIO1T03PY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNq3uDLP8piF8OmUYVfbVJqrCGO6YjK/NBFDBdiHIM4=;
 b=ceIUyu0UHWEJ+8epUhHzaZH6UB3HwfKeyWuqHW6tk3BHwhaZWsWUGQFJpy8TMtdDBrm3p327qLlsVk7CzWFj3EKTm8q+Xp+NoiAgI+dHcC66K0tqx5B4wD4OK19V6ojtPS7lvlVwVyPgsSjUwJVYXgCqP9sGti9XVoB2fizM+HASuzj3nIwXqChzBqc8FEdOVXBXE9SYeDP8zXKInKQd3mIKm2sd89eOd1ETrWYomXuN1MdIn8vbdqDMqcSU2Xn1bex0MuhLeqrxkCudmiUZ/NBAbSR3l3IREtDrtyV9H+bZHdhCJveRgJ5hw8UehgCZ0tzTbSCclJxdAkx9g9H7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNq3uDLP8piF8OmUYVfbVJqrCGO6YjK/NBFDBdiHIM4=;
 b=jedE6VmK/4b9LQLSyFz7udvc23c7BNxiWrW05zXYosDhMAcOgXvGz/tSGluvJM1zPhTeDwSsRHM8uFK/GXri6fqA98E1Iu3OHwbdg/ZGpPbf01J7xMzJDGj/Vmzb7e9ZJJEDffHFOJdmbQ5Asse1ujXi0GzvLH9hIxTzWOtrtck=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Thu, 4 Aug
 2022 18:22:48 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::9d56:faf4:482e:e6f5%9]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 18:22:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: pynfs clean_init issue
Thread-Topic: pynfs clean_init issue
Thread-Index: AQHYqBYvcZZh6BVquE68kijT9LgD6K2e4EEAgAABlICAACn1gIAAAm6A
Date:   Thu, 4 Aug 2022 18:22:48 +0000
Message-ID: <75259D5F-8C42-403D-B687-7412327CCD07@oracle.com>
References: <F80796C9-DFCE-4C7A-A2EE-4EB2075B9007@oracle.com>
 <20220804153816.GB9019@fieldses.org>
 <1C391A45-B2CC-4C90-86DD-1FB9C2000E7E@oracle.com>
 <20220804181405.GC9019@fieldses.org>
In-Reply-To: <20220804181405.GC9019@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2136a5c-c4a3-445d-3085-08da76465596
x-ms-traffictypediagnostic: MN0PR10MB5936:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ifn/Vr5ZwHCM07/7EB2XmzZe75pRvPUVMwnpGqAQ+p+808bSy0ozOBKiRXD9FDK7LuWz8b6j+2JSZOhezpcB1cfqR78513IXghL8cZvOvzgWSWFJJMPo8YnKRzWy3m3H6VsyWYE/1SjjhHiZOvQXZHRUiiEEKDHMXTnDfMsOj2rjxXPMkj6jWRS8gb4VQBg3zMmvBxwEnEXLtcE83g2Ss6AXO6Y/TsXblK4WENKV568QW+zNrLcFK6j7Lrs5K0ZWUcp4EtCAD2TMqQSAMyUUbjnOqweF6Ja6TMIEbpUpTa3ZD/7HXkugeRfDpGzr3voustvv2+Ob9JSQ8uad2Tu8rL6n4rykyBINjFvNE3rDq/KKBnAAXIiLqTNtDqNLMDEMRSIBc+5TZHgBDcTl5Xa1nsRI5ENEV2HyomnIzBS0Osa9alM+ZCYPV2uH80sMuUTJvWUlkTLtTuYNQ2DW9R4lhuK35VB9WTOGf78W1t0JxNauXubk/8fuPJzpFeyFDchYjS0vl+xP9539/5/RRARPoh1qxZJakzCLdIf+krmGrs9kBq9aZAdfvS77fkARx+vDMZuZhFvIqJlM56+Vuulwh4wCr5gMoqfsxuCSiO/XDJ9qrIuhVVuQbQPVb4ogzlLCnci8JrbRdMUMWMPvDQaGmKLBL1LC0CtsisuZz0zavRmUQx6ubXcFvLK0SkckPDdivgfwrMLEKvmwqbPOsBnN1q5V3Ayb0OQHaCe4itaqMCyHo8Du/tVjN0vsTM7f0cpDxfbZ8O2hFh5vFHwQ1cajVu3vmkJbwbmvKPwer8qGrSZDojugaN4T0hSXN379uBeyDHMKwJqNXOv45fy2L4rlQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(346002)(396003)(366004)(6916009)(186003)(83380400001)(91956017)(2616005)(66556008)(2906002)(66446008)(36756003)(8936002)(4326008)(7116003)(66946007)(64756008)(76116006)(5660300002)(8676002)(66476007)(33656002)(6512007)(478600001)(53546011)(6506007)(41300700001)(86362001)(71200400001)(26005)(38070700005)(38100700002)(316002)(122000001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3xsoCJ2erKWKenexspOfCBL2xhiKDbvsG2TFkwahw3RFcNjbjH9uIiyitveK?=
 =?us-ascii?Q?Fe3FaaBs8FXnrkEnqZhbGJebIK35VWSGmBWwnV70iMPSVqnfjPU7oPdciT6M?=
 =?us-ascii?Q?eu8pbgvZlB1UXnR3Uk2rJK7xVKkA3NOG2Iz9WwA30T9t5QsYQ8JB1+YkZK75?=
 =?us-ascii?Q?4/nS2r+kkPEmkSUgOUnxj3AQSH8CtHIRspaALbUmLpLzRgnFvy4JYq7q82n6?=
 =?us-ascii?Q?gVhBdVQ3nA4/SsaDuYWdbGdalg08/xz0a8h8/doi6JlSPjZoSETtjP4CJ+t2?=
 =?us-ascii?Q?52E4YKcZAunM9t3UPUROGvumybFBvJDFvLSzmXbbshYA3zAaLW1mbPVBSTK8?=
 =?us-ascii?Q?/VQDzliLQipIM+Jh3ChSC8wE6TL8MMReC6Ny1I06/+yFULmdx7gu0rskhl2P?=
 =?us-ascii?Q?ttCdNj5Z7sE3m/HnFvb9SQrpuJqY0HSrlo5B/OdhgW7YHLFu0C3u+LGVkbOT?=
 =?us-ascii?Q?/UzRglTwuNkV+HEiCHDrbT3fTQ/SvHtFP4KUOnjgHIWcaY3jLJJkG55msqEY?=
 =?us-ascii?Q?v7ODPszjxLgNA9BEPqv54PUCD5FYqJDJBuE7lyf5HkqrHSvVlI9692DM7xI4?=
 =?us-ascii?Q?C6U9DAuxThp1NFpgyFoqTmeTD/0jWR2xBhOQSE0kQ1M/OmTbTx2HHuKrLzb2?=
 =?us-ascii?Q?OexNPqcIzYatEFxRUIgkF5g8igEGcYUd/FFcKQlGRJJDfDGlR16Js2u7QcFB?=
 =?us-ascii?Q?HHL1kpmWCmjwTXD7l+6vGhpD5tSEldIZl/pIDKm3r0kBAoqfof9zoJMliwUr?=
 =?us-ascii?Q?u0ZR5iuf2KgViEp3guNHgftrAaurJXfbvm6cM3ohYNoVnBX4IhA2h/CplBo5?=
 =?us-ascii?Q?FTZu78WzeoHkNeoIfIDA/JqJklihdpRgagL/DY71mvIuWtxDEmM2tQSD1Ezn?=
 =?us-ascii?Q?EX72AnLk8AHEtnhRRdSttfhl/hdyG6eVGA1lB4SJt4KnTgq3YpUdX5cVUn4n?=
 =?us-ascii?Q?k6L2uDOecOpzmTx1N+Pn18VhRDa8lBFTBY3W394w1wOILgn6CC2exj2sYrE8?=
 =?us-ascii?Q?1BbzUuYoh2+As8MKyKUn75UrGVNyxkW3Sjzw8wJjvp7E1okD/3C53Zzgb3Zp?=
 =?us-ascii?Q?NJuFZ3aJVK91+sLEz7Yas70Wa2wCZYodu7SaOxr7e2UZKs0qLEWd56bST2Jy?=
 =?us-ascii?Q?VOFdfhS657QpcqcW3XTWGxTO7P6IQzBnYw4Vppcmyj+BOdbMeI1MVA+J8GN7?=
 =?us-ascii?Q?MbRPnVCHtMIG4o9PT1oznPqnmRQa47bdljFQm8N3+gJvl2eCnPZclmzFeeQN?=
 =?us-ascii?Q?HNei7pAkAvEr8lLdxxQ7TnOeMkN3HPMeCuVwCByhEOZ9TbeAc50thO853b/r?=
 =?us-ascii?Q?2J+8uEeBGavXiE6bQsObNg5Hl5phqZUa9FOiD9AV9PpIFjae7yHo7EEAaS2o?=
 =?us-ascii?Q?V1Fx+AX8wU1pnCPv1kJv1uP5f6ZfPmRrk3qkTd8SN907VAVID/oEGclyjA1m?=
 =?us-ascii?Q?/zwT9eNCVrnrIysXFbQUVoagRN0h7QAg3scVXIvOoYwLbKDAWn2ohmR6Sv4R?=
 =?us-ascii?Q?RNz30vkNKAiR9c15BmaVwWBv7ygjguCUJgZ0EosuoEuN97w1eGeI0A4zWnoH?=
 =?us-ascii?Q?GoVpmaD6zsIIjwVOwt4QusR1xHRxAVpCR7i7hqOG6FNB6XoTzFCeoGiMEAMT?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4C6E615EE99094CAABE01AED244F045@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2136a5c-c4a3-445d-3085-08da76465596
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 18:22:48.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUH+7vQuNz92DskLiDBQT0Bo9SvjoyaS+TdIrKY7wsj4XfPRLgKmf2jl5mp6bANC1QxsvnEUEcUYi74qPBL1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208040079
X-Proofpoint-GUID: a1BdsquDAqoF4WwYW8LDIB7a2F9wBwwH
X-Proofpoint-ORIG-GUID: a1BdsquDAqoF4WwYW8LDIB7a2F9wBwwH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 4, 2022, at 2:14 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Thu, Aug 04, 2022 at 03:43:56PM +0000, Chuck Lever III wrote:
>> It passes, but leaves the test file so that clean_dir does not work
>> again until the old lease expires.
>=20
> Oh, right.
>=20
>>> But possibly cleanup should also be better.
>>=20
>> This bug might prevent running these tests in an automation harness.
>> I'd say cleanup does need to be better about this.
>>=20
>>> I'm not sure what the right fix is.
>>=20
>> Brute force: keep trying to delete that file if clean_dir receives
>> NFS4ERR_DELAY?
>=20
> Delegations block unlinks too so that probably doesn't help.

Just keep trying until the lease expires. But that's a naive
approach.


>> init_connection somewhere needs to set up a callback service and
>> leave it running.
>=20
> The callback isn't too important, I think, if we want to return the
> delegation at the end of the test we can do that without waiting for the
> server to remind us.

That would help a lot, I think, and would not require an active
callback service on the client.

Btw, DELEG5 has the same problem... and btw, it's final OPEN fails
with EACCES... I'm looking into that too.


> Or maybe destroy the client at the end.  We have no DESTROY_CLIENTID
> (this is 4.0), but we could do a client-rebooting SETCLIENTID/CONFIRM to
> wipe out its state.

--
Chuck Lever



