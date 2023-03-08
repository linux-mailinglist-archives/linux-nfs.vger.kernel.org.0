Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE736B1163
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCHSvN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCHSvL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 13:51:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0434B71B9
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 10:50:40 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HikHs002849
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YpcbErnw3v9+T5UaYNczHML5DBHZx5LiavnvhdCy3O4=;
 b=fpFJKoit8XXH8nqq2HwQd8LsHGTjHRDeklKQO2cCUVUJkRQu+GHsuP0mPw4JrijhzOz6
 nngqRUeKiychFJrmlgPXC3TTHEf9ZvdFkeDGGESklwX/IeWUtpD3tYWVj054ddyb2w8g
 nvRQLFGgnQYLEA2I4d1GjRbdTrVz9nagmaiXjWwQ3y+anBh7DXaiGj/NOUbjUHiB3BZk
 iJDSgHVKwDLYG4wcaN5uE/g+crVg5JEonvzTLeG+joeFqxMQANkXiX2iKe7ZrbtO3kmb
 TEiyGJy/EX1EG5NeyNlCpTsuD/yUoz5JCQlHKexi+PVVmAQqXu1oFX1vmMFAJnqwuIuS 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y0xxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 18:50:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IICZ8020978
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 18:50:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu8d0mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 18:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAEOGpXR24ZMrjUzjrpvfa4xOJA2/98ko5D3o/qYFnaS/sYIQOxYaqiPqTmdoIFuRnSD2afGo6yHQpFrsddG6r2LsngL6qmyY5wiZmfZfCreMHAj4eeBkWH+IhT8NVymctBVZV0YmhJOsuYlWiLvf5tiArrXKwlcL3O+CGaPqJv9Sq6ZiohIKgrPff61EEaOmrbEuXTvyxPTa8rLHZQmLpI2dPeqtkpqyd7fEXddPpE28hWwZz2Qjv2OAzk31f9gF4Ls0ZMZ55bJKD66RIQwi11lcuBi/o2fVlVAoEA5Kcj2/0wSFZyaneUso+UK8LaynI7HaNbXcL1aspsueoWXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpcbErnw3v9+T5UaYNczHML5DBHZx5LiavnvhdCy3O4=;
 b=AisE2ehuZI0G5IYcm8GsZ2BPa/RuXOQ6Z0QbGP02BkmRwEyKRm7AV6YM2bL+e6du2pNqfJBYApavAqVp+y4pzFHfLAoyql5bESbEtLw9wG/epecuO38u/9ZYJgC7JbMCgvYti7Li9PfsYoMv387aYz94zwa2b7mnkZAu+bq+/uAx61YjLPZv8sbECl1Ab3y0TpkpDTw4aBUv26k9ghBrrPNUtReiJcDznf5JtOBOXbRLJdSyevNedquXlJzc6Ox4fljzvVKhiS7O3GrVL8sxOAxbdA029BWmSPKaxT1RUO23i+Pt3OO0K4fD4u1OLuzYpxj2kZsMst36plOwNR0PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpcbErnw3v9+T5UaYNczHML5DBHZx5LiavnvhdCy3O4=;
 b=ndsekGmSkyNIB+vslf7hVDrXKAvJJRRDzDDrqhDhCO7p+v8+mY1HZ8P2vGe63iGt0lVla328ZTE5yDZr9yY55igTZTt+pexxv6eDaCgp3TJO+XzJHHF9jh44epQ9yaoiJNPhEmHPlOXRpHrvYOUZef0AG1OagdF/NoPdaLNvMy8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 18:50:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 18:50:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Helen Chao <helen.chao@oracle.com>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Topic: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
Thread-Index: AQHZUe5IYt0u1Oe6Pkap8e148U2pua7xOd0A
Date:   Wed, 8 Mar 2023 18:50:36 +0000
Message-ID: <9D5A190A-333A-4470-8572-CF85EE9A8086@oracle.com>
References: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW5PR10MB5807:EE_
x-ms-office365-filtering-correlation-id: 4db15a28-3a2f-493a-7040-08db20060176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdW4834kQvPFLo5Gvk997m1+05Ddg7SwFfGFOPP4Ku8r5GogxsCxwgKFKWCUG4b0rIqo86uP1q4BCBNpHqZF6hZlXu6gGhj09irh2W6jmq5Oa0THrKpazCBpTmI+gETxZ0txGo3gjcWkbFExoXBb5bzTtWnnZ0piRFRArimirFyFMFSq2XKc5wVQYSxnFYfQo/LynTT7HRVrsGBbD+4QI3hwu4LxyBCd4FiGF+WCNOxO0havprtctSIn84TPIJ5FCWKvcqQyGEByv6s6g/3ut/ibdxS94buDA5WCz+1rsuiIKA2EO+k0w/POyn1JSB3DMEMv3B4OXUIrQBVOBfOxHf+S7FQKyHo9IxGUMxo3u7ao0oVaUfAbG86gXd+anrqNOgTN6CRskQvUmUqdoJHqVehHTnR0VMQo1mnHtKqQPzz9gfT6pb5+WLAll4X8jVcQrTbJejJI/RUT5BIWiNR+p56xu4xP3reXsE7XOiPtqICaQJmuyXXeGpNsEpc8kVfp1hGx1NL0/b/1lF4K62S3lNZEogNshKH3comcNtsVLPsz7C440ja4X4SVdZoqDYmfd0sRgv5op2oFk1hVz9edYQ6/oLfmo9fhgduMPqVuW88U85ahtg6ltIzwjd1nZAV745lDINL6cSozurPur0F7nOMy8oImLnuBtE3BiZ7jsJHIoQT5VCy1S8pZfHzlu7sQ9CEROAOoMUWDaa2scDsQVPycmGVBr8ayhUoxTKlHoX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(478600001)(66476007)(76116006)(91956017)(5660300002)(6862004)(6636002)(64756008)(66946007)(66446008)(4326008)(8936002)(41300700001)(66556008)(8676002)(54906003)(33656002)(38070700005)(71200400001)(36756003)(86362001)(53546011)(122000001)(6506007)(6512007)(6486002)(2616005)(26005)(107886003)(2906002)(186003)(37006003)(38100700002)(316002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H1qSwVjxqTuYyILZfBx6oU66DZrI7WTihLFT+NQoPoEijk3ifO3w9rgjuSCt?=
 =?us-ascii?Q?DdACBxeHAnjkergeX+vFaetft0fXnSkXMLfoP71VyZQ4msBnzc4qVGVOc1lb?=
 =?us-ascii?Q?NTMOO1d9/vG5zWpJttGd6cJ7+85ePEpnnvQ2/4qB0pDpc1RTeFR8L+HtqEpv?=
 =?us-ascii?Q?b5lvRmh1lEVhYR6fwgh0/nhSQrIPh8r0XOLIfQCqaBirUzhZTOaE4aQhtPkb?=
 =?us-ascii?Q?dM1qlB8D29LcpvVuKmaVr2fcJkBw1ZNSC4+ESq93lpuFqfoKkBVKTVLeBeDH?=
 =?us-ascii?Q?YkzjDs0NrZhwf8aAmukeS1yCB8xQnwgweVlG3czMJfgGYWnTjqfvH5c8mC88?=
 =?us-ascii?Q?3kjcY4vqhKr76ncSpqYYGBEmKuzkDYTG4OamkTOXqCn9FAxt70Bc5iIFt+78?=
 =?us-ascii?Q?MWqAHrjJ4Vl1F5W0N99qC9sT45gS8kUscZKSB3wmLA2fX6cY/bOdzvUn82+V?=
 =?us-ascii?Q?k4mMQ/NXos19iQfavn1HfKT+Q+7TNW6qQ7OVL1mJAm9da9zaBzoCGwuDSE1E?=
 =?us-ascii?Q?fIGu9PnOc2dZ3hhsBHzZai6BKJzI68trSWlqkFbJKapaClrJ+S3CkMmri7cO?=
 =?us-ascii?Q?etMKoONXtrzJ71zKuqkimZmd/kqbTtrSmCBfdYLi3fTFGItg+lrxO5/SRxrJ?=
 =?us-ascii?Q?CMYAx7aRGRcy1uXNCY+jHY6f20as1u65O0Jw2MVp74tjw6akhyDASC9bxdQs?=
 =?us-ascii?Q?QkaAb1NCfSJv1U7+IKpiokCWiV9e+nz/h/sBkLULqYXo3SwtMpQm0i0nhtLP?=
 =?us-ascii?Q?WXJjDTJ5RtvEw8TSAVlv6y+LpVqejAMQRz9TOOSjhIVMT0IQmwpBKlAbsM62?=
 =?us-ascii?Q?stYOx6ljSNN44aLtZkB70KjnOt+t5RBwD2cMWcCZwrixsvLCIaTJiX5jEsHC?=
 =?us-ascii?Q?34FS0Se6hG8XNYjwiH5k5VWHG+Lmqec3Qcp2tW9oOyBeZnirHi5RUtnyWaTo?=
 =?us-ascii?Q?DtmXtnkyCJuo0zObnj2Stulufq9BP+1J8lVj3IqxqzwT42qQv3yVNNdo5C3q?=
 =?us-ascii?Q?pCnRhLgGKRF8Ene9oSd6tffHHy1p5A7DWKTxyHdur3P5wI89vh3mtYE8kyyP?=
 =?us-ascii?Q?bO9kYpic9tNQnqULkEAHzpOyr7BH0Xo+FfcBWN/u7fKDM4XTXsIA7eupar/C?=
 =?us-ascii?Q?kvKC/NP6N+u7UdmiTfMymqszzG+fsrkpJN/AHNcd8h0labeUsSEOYEv3A4YT?=
 =?us-ascii?Q?SjoPzRmuj4ZVuWNvl42y8O6ga4emiuQe8qoZ5TUgwaaFntLd9XTbg/wwfi4T?=
 =?us-ascii?Q?5St3ifJ2hSVN82yCWscIMw8bio/jgpz3Sl+SWMG1EXhCL36Uu8qGlS+Khh+t?=
 =?us-ascii?Q?6l+OBjQrgeHIecUPylpEePoLPWDDh+Ggkmv88zyubasVbvlZt2hgVuCg4mc5?=
 =?us-ascii?Q?CidTFkOoxJ5s7ZoBthelID1on/lybVA4z3SXrjTWHJY4cyzereab0pPOpaXn?=
 =?us-ascii?Q?AwJX0fVBIH6wRRdeDzlN9zlKOE/nLfii3Y5r2Vuv/3zH/NjxpgINIMqnCkfD?=
 =?us-ascii?Q?OyLM4SNLwsUrqrAWI64H3OnOGuzZe0Hkjo/j453wWlAJEYBUOA05j6rvtJAd?=
 =?us-ascii?Q?Mwbu8Sl0wWgrH5YWop2GQCVAw/TBASE0eyEo/apBP0f5pmeoCnntl1nq9agv?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29CD6044E95EDA448876FF5FB34B3DAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WW1KdywnC6n2GmbQVMTsxBKvm1YfWjgOewuhi+sDzhtDGDCZfL2RSP2uEK0DAKmgSY450DWNeAWFb9QT+wvx2w003rmMjEuqAJr5UxzXoSCgd4SNLe2zdiIRre1HlNd4dCt99UVRpE4zHh5hV454nMlNIXSLGRsOn7smpR+E1f1wnJsHGOG/56R3z3NPB3PhN/mXBugXg0ZUZCUVKA16o6ZSbLju8+kwyEHU4jH0DUQN0tu6EakP6O7oTXNaepO6VwczQEZsDf0Tg7xxH+fmd3h3RKmxchAM0RUedsGoH0G/Vkat/24uv0M/jbDkwV7ypr1auo/TSrb3L9BIPLCtTL6QPi9GXF0aS14Y8SQWDg7bMCHVZWyEbAKTrIV7hQpGDJ7AwUZIENjlwTkcGo1r/X7cDMxZT0wAQ+zfJZImV8Bxhl0UEZOY4XoxJ5QwcVjJjhW9QlZ62YHVBoqKNEMCQv3OrvUcJJqHZwzAxd5x4Hjg0fiOD3eEsAd0FnFg30dhRDSUqnDaIxrJ2UhhFm8cPexpFJpFdDbZlPBKgdrK17Fp+tIYaydIN4ZIjOj6zYeXQlKLL3EyyZSsOa/Day2Pk7kT87Jp5w0W8psZKfRzENnc50IhxTHdhUHbBKbU0qiCk+V9oaIeK/dzEqb5Mp0XHOSSQe6FR1wHCPoMYISNV0sMU4JB19SIR4ESa5VvlnyfMd13NT7IogPeekBR9QYaRjo7HEg4Xky1cxFJl4scrRTj/G7vq/hTwJEtxzVqnjQd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db15a28-3a2f-493a-7040-08db20060176
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 18:50:36.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqlQzurhM/nboHTOLb03aMeGM/kKaxuaZWp2FTwBpHs1/uZfD0mE/rWLnQhnpUw/3IClnncRn0t4qhUtQzU6Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080161
X-Proofpoint-GUID: baBkQrNDkqGEbX5fITqoNrDQyD9_NNB_
X-Proofpoint-ORIG-GUID: baBkQrNDkqGEbX5fITqoNrDQyD9_NNB_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 8, 2023, at 1:45 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently call_bind_status places a hard limit of 3 to the number of
> retries on EACCES error. This limit was done to accommodate the behavior
> of a buggy server that keeps returning garbage when the NLM daemon is
> killed on the NFS server. However this change causes problem for other
> servers that take a little longer than 9 seconds for the port mapper to
> become ready when the NFS server is restarted.
>=20
> This patch removes this hard coded limit and let the RPC handles
> the retry according to whether the export is soft or hard mounted.
>=20
> To avoid the hang with buggy server, the client can use soft mount for
> the export.
>=20
> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
> Reported-by: Helen Chao <helen.chao@oracle.com>
> Tested-by: Helen Chao <helen.chao@oracle.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Helen is the royal queen of ^C  ;-)

Did you try ^C on a mount while it waits for a rebind?


> ---
> include/linux/sunrpc/sched.h | 3 +--
> net/sunrpc/clnt.c            | 3 ---
> net/sunrpc/sched.c           | 1 -
> 3 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index b8ca3ecaf8d7..8ada7dc802d3 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -90,8 +90,7 @@ struct rpc_task {
> #endif
> 	unsigned char		tk_priority : 2,/* Task priority */
> 				tk_garb_retry : 2,
> -				tk_cred_retry : 2,
> -				tk_rebind_retry : 2;
> +				tk_cred_retry : 2;
> };
>=20
> typedef void			(*rpc_action)(struct rpc_task *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0b0b9f1eed46..63b438d8564b 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
> 			status =3D -EOPNOTSUPP;
> 			break;
> 		}
> -		if (task->tk_rebind_retry =3D=3D 0)
> -			break;
> -		task->tk_rebind_retry--;
> 		rpc_delay(task, 3*HZ);
> 		goto retry_timeout;
> 	case -ENOBUFS:
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index be587a308e05..c8321de341ee 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
> 	/* Initialize retry counters */
> 	task->tk_garb_retry =3D 2;
> 	task->tk_cred_retry =3D 2;
> -	task->tk_rebind_retry =3D 2;
>=20
> 	/* starting timestamp */
> 	task->tk_start =3D ktime_get();
> --=20
> 2.9.5
>=20

--
Chuck Lever


