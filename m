Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09E6E2B58
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 22:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNU4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNU4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 16:56:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F53C33
        for <linux-nfs@vger.kernel.org>; Fri, 14 Apr 2023 13:56:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGur3C028707;
        Fri, 14 Apr 2023 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RPZyhwyMel1f5tjNwH/7UbVFgfkGn9AQJgkzEydIy+s=;
 b=dmicQA7/oNwyyjsRTud5Le6HzvSZx4rCat4MW4sUkjNDOpnj9kuxLRMbbUjDZ1wq5QBt
 1UZdwSDGWJlCzGacrJ6BY50QHsIJyHLTKN9ccDcRXYQRC2f4tsY5HP+j9JHoLOlBeeXG
 Br8iCPhDqYY5k8O/T3O819gN36ioNASoMv7QRbKHdQ1L0SCSpG/J9s87o0FQqyA5Gcf9
 xaLJQfFkj6OQ0xRq6FD0eII4KjdfuqaQ+3WvRvqTrZ3C+CHPJo69YMQMJkEk6n/ASxk6
 Vi/4q49LLfgNJ644KXspardkajHL2x7vy6q7ccYuAulIYw13RZg35eQthIWyJIcO8WiQ Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etxs7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 20:56:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EKRihD020964;
        Fri, 14 Apr 2023 20:56:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgsw74h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 20:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIBGEa9xcM8w/Y9a7Rg3XJBEmAKGacpGD0c55y6pQ5WzyTHtXSP7z12c2dCu8BoyjiEwSPygEWTrEjtk6bbe+W7mNAugpo1TweDnVtAE96ozMzGddXIjdTfOrfIZI+Q1XLzXYzjHVnWajIZOqUCBnfmDf7rvzZQIYreFVh6BwLx73KZl+yzGPsP6wxETEPvouMVvyzS099Bpn9qOBvmq8KCHLO6lsrsda95YuCTp90D0HkvxcE5we6tdhbo0zHUZgtitm3GDBP9ah/R8j0zA92FsLPphANc6B08nKZqYTAaBbX2nQBhutN6BCze8kUElL8j1FJLGloihR5B7S2Vc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPZyhwyMel1f5tjNwH/7UbVFgfkGn9AQJgkzEydIy+s=;
 b=eNGOLvVMHXCp1BkugW1a64L/PuCWWJeY1V0fbqFR6FDheeyNcPAJRgS10dPwqky6lDOSiVcZ9SBeTGWh5kzwILbbf5syhK5JW8exrNndYP9/B5pZ93D7pua3B0CnIUzcsVkaqDf/GZx60AMn6bWshYQ5EKPzPmD6MhfomQBsqceNLijw+JAN/4xZW8xDEovyAWQ2TsxBO3eWllJciyfPdCAgp5vo1afbkbGi/kus1DvnS4W2Batf2P6icVli5iNHNGzm9bz/cYNolRqdvr8tfaYIUQZU5/s3RHPl06o7ZJVM9gN8kID6GgsNXd/l4HNqsbdxX1HRxA//lkrBKMBdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPZyhwyMel1f5tjNwH/7UbVFgfkGn9AQJgkzEydIy+s=;
 b=ODMqkz1PoPxWdMLEQeytD5HU3cdU22Jamlm15ndHsIc3j1FyqQ0/G9ZdtqynDE159X8dSHKqSiCNmQ/HwlXpWAsnm6Iyl60dCKS6hn9F4BXek6nToL1GpfrAv24bCie90HXfWRQkBw7y7THGAA5fei83aNwzU+0LQjpvQ07HY5c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 20:56:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 20:56:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Topic: [PATCH 3/6] nfsd: simplify the delayed disposal list code
Thread-Index: AQHZK2K9iQAA9AGCR0S9mUeEchObFK8rpOWAgAAPx4CAABudgA==
Date:   Fri, 14 Apr 2023 20:56:16 +0000
Message-ID: <FD32C9C3-0CD5-4034-8D85-E118FE9033C9@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
 <20230118173139.71846-4-jlayton@kernel.org>
 <7810C14C-DC16-48DF-8A14-1A1E7B9A2CD8@oracle.com>
 <be4b5a40778b4e8eab7c0d8943474cdc8f2b097a.camel@kernel.org>
In-Reply-To: <be4b5a40778b4e8eab7c0d8943474cdc8f2b097a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6642:EE_
x-ms-office365-filtering-correlation-id: 136de431-47ef-448a-7594-08db3d2ab063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAFCqorYzQzYmwjz608vyDpPnLbOc4mqRG1VW9fn7d+C9/aaVY6VmOqDKoSXAZHrd6jq8RF3koHrfjZql4vYg69OIVwCBqBcJndGkbtamhGhoSh+b/T6+jMNY8Dx480DNDd9zkTKwe1/RR+IinA71UKndgBaUOj0UlZuKMAzLKbvlh8RN6oRqW6gfT0yNv6RtR3Ese6rKZuq/9cWQFPOu7U9oQVzUEEYP3FolOR+vZrZnsx6zjeXsEQbrkkTAEhrkUk7mA1k3fVax7qxZHF6rslmBWoIebVhJdcQ5CfXlK3WSkw11sHSwBWxucrzJlQPH/thMIMJIpy0ST558uKMqF1i2IaHy5FFo2SnMDBVLMVdV9uuzDABkKmm38hb2wxlY87uD57XrRHZSbMGMIW0UgryxGKMj1LK6T9bCcCj4BNTepYXt7LCwPYz/qFOlt1DRNYfzCU/U2cbQZnIElsb5iuVn/WgG3WSCgUi8+O8++erFhF9Ev2Vkt4hCiPJSUYK+V8y7oRTclrEUnQBcPkZVEjMvglpWWbFVI2HtciXkdKZVS2qfxalcDppoEUfz2NgMMYGmgmzaG6m0VZv6CsK3ex4DBGhRa1lfec5cU7gUy32xLadJAzr6l8q/uwt7JVqPU0Pq5CtKBUHcBob4tWr7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(122000001)(5660300002)(38100700002)(36756003)(2906002)(38070700005)(66946007)(8936002)(86362001)(316002)(8676002)(66446008)(41300700001)(6916009)(64756008)(66476007)(66556008)(4326008)(83380400001)(6506007)(76116006)(2616005)(91956017)(186003)(26005)(71200400001)(478600001)(33656002)(6512007)(6486002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z7qEHQuSvsXLapTfFnTpdav+1PAkOyAglHOUpXOzqZJx6vyQDydt7tbdd1Vj?=
 =?us-ascii?Q?ptgMrQY4O77XLeXAPG/u1CdL9AavRc+LXVtcp80CYkAdlZws95mWu4cZRb3G?=
 =?us-ascii?Q?GzoLrjImJoCQkFSI2ie+XKNj0UI5x1s/8qwU05SNKZH2dgs9kKGYzcl2Nttt?=
 =?us-ascii?Q?3oEB2NlgX5sZbOcLYz7xK5UdG+4ABZj8p0VcjnyIXNSmOL01lz1tuncpPQDf?=
 =?us-ascii?Q?F/KjXngaquKG1nCmo96L40z9NdUo8XDf9S5U2xZeEsWhCwUpQmiL0iaY0Cda?=
 =?us-ascii?Q?p3QR/oMLYExNKwzzaB1887kcf/cK0V7Cr6gfC25ap0s6viJTqil8N6WyIYI0?=
 =?us-ascii?Q?Q2Z981vfHckP6JpLPtDU6P7I2C3MIN5HfOH1I8xgnQ7f3giIYjm4gll+OEkt?=
 =?us-ascii?Q?I890C9Ao0jyS4j9LJZ4jdqG4uRTQQ6G42OeiheC+eo3yIgKe1LK3ROsbHkYm?=
 =?us-ascii?Q?jK68e24ZMOoFg41/fWA/zN7vo0OiegpHPYnMV7tHV6bg92D9VTdUyQ5gpg02?=
 =?us-ascii?Q?eddh4Q41GZa3/C+aWq4PsiaDsYXxkn/zG5lOLqSuD5LO6tpXUMObCCckiP6j?=
 =?us-ascii?Q?2po+uGs8lUN3LUrUNHKuyeoeMo9ktomSpmPCyPQ32E2prD9FwPB30utZf9c1?=
 =?us-ascii?Q?ghCpBVo204s3L2dyxXwKQqiuI1/66DGU2z9aa4DmpcrcMiIv6jP77A1lXumD?=
 =?us-ascii?Q?twLSKE3x+tfthpsp9p7M15l2WgarbXfU9chxy56wkmnmHM2am8VYs4R+RPpi?=
 =?us-ascii?Q?HKRwuEj/liD2qQi6H9yXMyuqq1UR6iNTHJZY/gVNp2hbEfOrZ+CaZ+/BBJ2p?=
 =?us-ascii?Q?y7uyph+E+V8eqUThM0zFyyHMfxUOv+2VrpsqD2+WZQ7M6U01p0LdwhLYK+tL?=
 =?us-ascii?Q?dT+z6crObxIzpt6f4lQC5m8z6SDxJH0HDKIwYQqPTF1t+67gY2IFiTOQA2X7?=
 =?us-ascii?Q?B63ut70PvVlOgzXf6jOcITaIiLJ5LAfjd2w5jxJZ2ON66LSPoSX2Kh/CiAO+?=
 =?us-ascii?Q?KktIYY6DNFaa/PXcpvbTlUtlH5s8/HgcrF189KGrkHkT/Km6Bfn26Plo9vC4?=
 =?us-ascii?Q?EuqUxH6T21ug8zptTnqK8iZwILAcPJoB5/NUAzphUTgvSuDMjDBI6oY/rCym?=
 =?us-ascii?Q?LGgEDnqhvZ7SBY1kE8s1etOxFFY3xa8uBpC25bk2Zq3O3OL7eMATNxNGNQUL?=
 =?us-ascii?Q?pgzE1VnD1QKKn6Cmu864I7p8GPtHq2SuBrrXgsNaQkj913l0w9wMLt7Ievpo?=
 =?us-ascii?Q?7IGH+j5X4qrWY54tywv3UOThz5XCh1Q1PiFAJgeqPO/fwGuZWJHpxdJRYwns?=
 =?us-ascii?Q?QeAeYm22QzdgpOmgr/+6jHAXBwzxOevNGzx60G2mj2cqKJnbDKFRqNFzEc52?=
 =?us-ascii?Q?KWliq1mvb4jSsBrfe5o3uYCQ1crhU3FUxDIg6FE65fCXN8ALMjqW4R90a24m?=
 =?us-ascii?Q?mvO/bivZpRvLunjNlrphAb2QACrMw0+MRmE7VkrnBkb2kwV4j0gsudKwslfw?=
 =?us-ascii?Q?UtkJAWi2zK8g1QXU9KohJHXE8lz1P6gFHHylUlLhixIEQgrRSJtp+UJSX8Ed?=
 =?us-ascii?Q?mFtGyGC57ZY9noHo0UFgNm0TNLYhiHvjc2ERMF2kkHNePlziUaHYM3MoMacu?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2A46F76421A2A4397975BF973CA1B95@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lno4mn9TTdTUBF/NkrycDpjKzOqwhJRo8KsXKxcaBgVy6ix6cOtTpNVLkp/ge44FNVEx8cIG5N+lM+cD2dulK87VTivW6tSbJvqIJ/2jgB3CdCPmYd+nkZDuXKBoq/3g/bRy7aJQa786HlI2qFcWqXVvnsCb3d+Zhb9kiUW4GQN/r1HHW9XJpYyigG2BFSsdYIy+AwAqtFrP3Sy1hhJnUCx5XBj2P3P+sZvItOSd5eTsnkJm7G1U2JLq3H3TwTUn5QVRoGwKKPJwivW0kzY2TtfEnnDJaTxmyASlCSiubqEv697nKImAtPijXk/7nECR29JCPc/z4663O4RaB5h6JFsHkMHCW1/cKmdQ7Lh6wMh1s8Rps3LLUJVFhlVxXWBvNV65AGHF3Xfu6Bu3HTKElET2ztMHmcgyUkKsWTXj4EWXmPWf3DdJNyyk4C45k/z3J0d0A1Q1OVRXcCYhY5mMybLyZo55C913TBpjaR6pmp7htkoXX3PiXwhBTLs+vTgpEyzTkmyZ8FBkuhn+aevLs/MeqRzOPdZba+M09Hfyr0prN26NnfsQImEQTlcl7qapFaSju1m3wP4sOPbymDkOYfbCCr1i8/vS9agVfVXDcL6qe68ybliDBo50KEgm5hLuKTY/Y64D2yFFt/HTdgP7Tu0pBwii4DNo/Ot3n5J5lx8+UJXqmTVaZH1UcMsc2Sa2uO8lJIp+2yqkzCTn07KlL68pAAEobLL3dfSIm/Xtt8PYS3bxaQ5ZhEUDL8PBXkjUbEURZARgdanxOkPcX0c6Q4xdMcyWz2CRmxR2qoifAoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136de431-47ef-448a-7594-08db3d2ab063
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 20:56:16.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YxlWpS092zDaGCBqRN/uSIbr+WRtYOYKStDZzYJChNINoGxQMiYzFpx2SdukIsIsNhy/Gmz4L4o2VHU65xszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_13,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140184
X-Proofpoint-GUID: IBRF8fRSU8TH43k18Y7LPkSWTZ0e35hG
X-Proofpoint-ORIG-GUID: IBRF8fRSU8TH43k18Y7LPkSWTZ0e35hG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 14, 2023, at 3:17 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-04-14 at 18:20 +0000, Chuck Lever III wrote:
>>> On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org>
>>> wrote:
>>>=20
>>> When queueing a dispose list to the appropriate "freeme" lists, it
>>> pointlessly queues the objects one at a time to an intermediate
>>> list.
>>>=20
>>> Remove a few helpers and just open code a list_move to make it more
>>> clear and efficient. Better document the resulting functions with
>>> kerneldoc comments.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/filecache.c | 63 +++++++++++++++----------------------------
>>> --
>>> 1 file changed, 21 insertions(+), 42 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 58ac93e7e680..a2bc4bd90b9a 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -513,49 +513,25 @@ nfsd_file_dispose_list(struct list_head
>>> *dispose)
>>> }
>>> }
>>>=20
>>> -static void
>>> -nfsd_file_list_remove_disposal(struct list_head *dst,
>>> - struct nfsd_fcache_disposal *l)
>>> -{
>>> - spin_lock(&l->lock);
>>> - list_splice_init(&l->freeme, dst);
>>> - spin_unlock(&l->lock);
>>> -}
>>> -
>>> -static void
>>> -nfsd_file_list_add_disposal(struct list_head *files, struct net
>>> *net)
>>> -{
>>> - struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>> - struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
>>> -
>>> - spin_lock(&l->lock);
>>> - list_splice_tail_init(files, &l->freeme);
>>> - spin_unlock(&l->lock);
>>> - queue_work(nfsd_filecache_wq, &l->work);
>>> -}
>>> -
>>> -static void
>>> -nfsd_file_list_add_pernet(struct list_head *dst, struct list_head
>>> *src,
>>> - struct net *net)
>>> -{
>>> - struct nfsd_file *nf, *tmp;
>>> -
>>> - list_for_each_entry_safe(nf, tmp, src, nf_lru) {
>>> - if (nf->nf_net =3D=3D net)
>>> - list_move_tail(&nf->nf_lru, dst);
>>> - }
>>> -}
>>> -
>>> +/**
>>> + * nfsd_file_dispose_list_delayed - move list of dead files to
>>> net's freeme list
>>> + * @dispose: list of nfsd_files to be disposed
>>> + *
>>> + * Transfers each file to the "freeme" list for its nfsd_net, to
>>> eventually
>>> + * be disposed of by the per-net garbage collector.
>>> + */
>>> static void
>>> nfsd_file_dispose_list_delayed(struct list_head *dispose)
>>> {
>>> - LIST_HEAD(list);
>>> - struct nfsd_file *nf;
>>> -
>>> while(!list_empty(dispose)) {
>>> - nf =3D list_first_entry(dispose, struct nfsd_file, nf_lru);
>>> - nfsd_file_list_add_pernet(&list, dispose, nf->nf_net);
>>> - nfsd_file_list_add_disposal(&list, nf->nf_net);
>>> + struct nfsd_file *nf =3D list_first_entry(dispose,
>>> + struct nfsd_file, nf_lru);
>>> + struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
>>> + struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
>>> +
>>> + spin_lock(&l->lock);
>>> + list_move_tail(&nf->nf_lru, &l->freeme);
>>> + spin_unlock(&l->lock);
>>> }
>>> }
>>>=20
>>> @@ -765,8 +741,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
>>>  * nfsd_file_delayed_close - close unused nfsd_files
>>>  * @work: dummy
>>>  *
>>> - * Walk the LRU list and destroy any entries that have not been
>>> used since
>>> - * the last scan.
>>> + * Scrape the freeme list for this nfsd_net, and then dispose of
>>> them
>>> + * all.
>>>  */
>>> static void
>>> nfsd_file_delayed_close(struct work_struct *work)
>>> @@ -775,7 +751,10 @@ nfsd_file_delayed_close(struct work_struct
>>> *work)
>>> struct nfsd_fcache_disposal *l =3D container_of(work,
>>> struct nfsd_fcache_disposal, work);
>>>=20
>>> - nfsd_file_list_remove_disposal(&head, l);
>>> + spin_lock(&l->lock);
>>> + list_splice_init(&l->freeme, &head);
>>> + spin_unlock(&l->lock);
>>> +
>>> nfsd_file_dispose_list(&head);
>>> }
>>=20
>> Hey Jeff -
>>=20
>> After applying this one, tmpfs exports appear to leak space,
>> even after all files and directories are deleted. Eventually
>> the filesystem is "full" -- modifying operations return ENOSPC
>> but removing files doesn't recover the used space.
>>=20
>> Can you have a look at this?

> Hrm, ok. Do you have a reproducer?


Nothing special. Any workload that cleans up after itself
should leave the "df -k" %Used column at zero percent when
it finishes. What I'm seeing is that %Used never goes down.


> Actually, I may see the bug. Does this fix it?
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index c173d460b17d..f40d8f3b35a4 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -421,6 +421,7 @@ nfsd_file_dispose_list_delayed(struct list_head
> *dispose)
> spin_lock(&l->lock);
> list_move_tail(&nf->nf_lru, &l->freeme);
> spin_unlock(&l->lock);
> + queue_work(nfsd_filecache_wq, &l->work);
> }
> }

Yes, that addresses the symptom.

I'll drop this version of the patch, send me a refresh?


--
Chuck Lever


