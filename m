Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3501693B97
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBMBHZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Feb 2023 20:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBMBHY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Feb 2023 20:07:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE16977C
        for <linux-nfs@vger.kernel.org>; Sun, 12 Feb 2023 17:07:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31CMS3hP007256;
        Mon, 13 Feb 2023 01:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5kBzESM6ai+7oPbev4CjghDufniAiE2a+9n2VWlTmpU=;
 b=HMKrqFMqvfkxV3ttztKov6PPNqZ8zJUPuOJjyek0n54qToePDtkZMFwcQDzLS0+l/nYK
 RSD2caeqQQombR9SW6IwhrrFLR2+MCFX0SSxumVmmQ3V/+hmMC5MImuDWYEOu3X+9sGx
 Y8Occ9Sx7RybxYGmVhm4In/+OAXLJuYZgVV/9SDT+lA7TFygXStBv7VsWfyXB4NE+b4s
 35KXlgIHPlb3kEEDS2CRZvKhCA7gjuQqk1zb6fr6KuGl0Edf8/wFPTdofvci/U+SDBc+
 ldkA9GbKVruvn8EEImVIxkbUMeufmW8QaT2GZN8h4A0HxLIqP/MdOQTT1knYUSgMXGkR tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mt9nuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:07:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31CLWsZ0028908;
        Mon, 13 Feb 2023 01:07:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f379b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 01:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRggNKzoKmxiCKsAviV9gKjG33oi1FB+yJSjZJizGjHAh5aXwe8DTVOKq0Mb/nkpeuypwijjAUS1G/+uUmArDw2ms0/TL6oK6jWhhpkSM+VjsHevN538Ten2vue4gJl2SA9hRpt93vTln6wEFyCSjeV5f0T6PBpLhRc12cblCA8amY0YVln4U8n8c7yOjk76vgbApkeSLF3GBJLGzQkYMcwg+wBlCpSqfv9neWRojpluz6Xf4KNwyzQrUpzNWbtuoyHndF82HTuAg2Y+ZUIb4mbCoLB7bdWIXE+NcBPwpk7iteXSr+bjR4wT1zEFUewjK1GoA+nvUMx3H1K+rpHHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kBzESM6ai+7oPbev4CjghDufniAiE2a+9n2VWlTmpU=;
 b=oeLWLAMGjDBHoBmO0oDSrsxY/rq/81m/NvVdl7ZD2wzhwDuwpj5cgVmVFhxdARursVNGtiC7X2cXRJs1UjkjRTEX3N3PWaCwWsaZibMno4ebvQsveoNGfeOHXs16j6yj7mOwLi6r5pVD5hAnC1LdbV3wPtwIhSf3teLgLw9VhRkVyCXI5fwYccJtWeoU4pOzu1b3Ut0EIZ7XpNe5x5yxK9w0gngRHPy35ycPc2qF7T/fTvOtSwDGHnorToq4Yxq3YUdcB2+I8FWVZibpNdsJrGp3NwXGonigtUh9dwkFiHcMx+mLIGLG7AvJMVingh4wOTXcNim2qCYb5DniEaOTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kBzESM6ai+7oPbev4CjghDufniAiE2a+9n2VWlTmpU=;
 b=YPwGV0jjZCPypV8zfeHAqsmhmVK6TsrdWlzPK0CBh+g5Q2DTXQwXXjGgBsot9wGORayRHu3fPlka9YBYsViNduWVhtWvsDAOK+X0GlHCIuQksm7jj7iJpAIvkyl68qRX4m5uWaVosyVERR5LOfRRZ+/hxl3Rbvm3a00mtLWM1xo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Mon, 13 Feb
 2023 01:07:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6111.009; Mon, 13 Feb 2023
 01:07:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: question about the performance impact of sec=krb5
Thread-Topic: question about the performance impact of sec=krb5
Thread-Index: AQHZPqeMez/BkWTmQkuEvdu9Nhcyhq7LltYAgABTYICAACd8AA==
Date:   Mon, 13 Feb 2023 01:07:13 +0000
Message-ID: <84ACDC95-5354-468F-A5F4-AB934AF61728@oracle.com>
References: <20230212140148.4F0D.409509F4@e16-tech.com>
 <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
 <20230213064552.3960.409509F4@e16-tech.com>
In-Reply-To: <20230213064552.3960.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6609:EE_
x-ms-office365-filtering-correlation-id: 1da5e73e-1ed0-4a40-1458-08db0d5ea459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x77g8qBcht4E+U9TMAg+Tq7dZKSMvek1HtV7eTXvepfEjcpAcMmCVqb5ZbbVCRQ5UTRL9PcnVzXCkd/0aSL0s4uRLX/rGYaZn9AHqV5ai3TW77gqPjXBBp/SoAlyeA93r13/xqR1fSzZe67VVu+G4Ad/DRz6HxOR3dXxs17kGLLedofNm6xCZPANJ+DsFo+ag24kWwaFd5gvsY4MnkvKkuuS2QwtQBJtAjA+jrBnxnlwIF4UqMRc+CJkD9HWop9BBcCR6g/woaFlKYYeI05bZeS4PbNiQuBkfTK7xcrMWPgczse+36QvriISA8VcH9U+ccLnLX7d0HyhXv4IfrTjLsyfWwpT7nsucMSj1h1OZlgKVHObr3zcQUd1cXmsl+zJXZ0Rkg+ylUlkFUYHlxcUJux/9J9L4AFmxNZ2Tsx1371ifrbOd+/1W2NgopCZnx1HlDVySQ3ZPDW7RH7PL89tzioUOG46voxvXh5J9yk8NnQQSnvT68t8ZAxtu7kOkP2X6c2OKm79pS0y7XznUqKYiKj3Ju5IAS5oXARwoTQw19jfwP4FQjNR8768ZhJAlY37zfqfyzk4jzA/LxvbKhkhfzCRY4Hxz0rGly+DYSl5yBtfj/IsoiIUR/VIPfcCU0hJ6eVSbN8IBta6u7nPZjiW/Ek7CHLNoN4w1tX/jy0j0gJs9bHuJOewg0JkKGx/aiUvLp8Mb9GBErmuLD8ap5yVZjGj12E7TMLDEU3YvnTKOicMOYwA18sG/SLEH5NZddN9g6rXAb1HWlUstYPnHpnQag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199018)(66556008)(71200400001)(6486002)(478600001)(54906003)(41300700001)(53546011)(66446008)(8676002)(6916009)(66946007)(76116006)(64756008)(6506007)(66476007)(4326008)(6512007)(186003)(8936002)(26005)(5660300002)(2906002)(2616005)(316002)(966005)(83380400001)(66899018)(91956017)(36756003)(38070700005)(86362001)(33656002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4z9RQJ2g5uuZE/zNhC0c16KUauEuC4jbQE+g16ebxBtGOxtkaEZkGIj1/M/i?=
 =?us-ascii?Q?0SyjhTfOshwSD2CVDDSFb5qDGrffxiWOlSa5VTlnyYPrdFjr9gQ8bjL3FdfR?=
 =?us-ascii?Q?rotMCj/uXiVDw4fEuv6Bjd30hDTgz+gBtDe43gEOCjrLe3B8tVCKAZgKszys?=
 =?us-ascii?Q?mbq8Co8qn3OAN6B9oH4HczCG9ffWwBTPw5av98jGpHR3UFoMryqAc26zOj8x?=
 =?us-ascii?Q?lgcc2j75FLTNugEbDYDGd0nwnvEQGiBs9Gtpvn7JQBxkCAlpGmkldtUQr6az?=
 =?us-ascii?Q?/HKIXCQFpofmXZgSXggDDu91sq8um/yGBywsuI80UCLFymLeGJya93bpC5Uu?=
 =?us-ascii?Q?U+IJSvuHXz2ms6k+UANDcClT/95lrzv0zZyi/FmjEAjFtseB0cZWyfA8Qf34?=
 =?us-ascii?Q?iBdJKwsdk6pJ8xiD+6jVgMwWNlBG+Wf3NDgL4yKZs+109fMUjaqXes00tMoe?=
 =?us-ascii?Q?EF50UMN4u/0hU8Cdd7qg7smyNWkQIzNnwK4De8gkAQNLaEP8myn1MisVfj7Y?=
 =?us-ascii?Q?6M19GV9uKy53uSZMbwB0VE7MzecSjwj+6PbF8dGh/ZS3S5sFYfyYN6V+jIIv?=
 =?us-ascii?Q?llcT/1eq9ijPSW4b+kUzu5aBlNVuUuaSZdY28O7f30EMidWo+qb+hgpbj1N9?=
 =?us-ascii?Q?zLdrnbm0e9LXFXAeu+xUlCZQcW0TtdzrSSmQA9sRH2c6TkCHEELTYL8XI/Cs?=
 =?us-ascii?Q?xgGGf4IRIFSjWhCfziJzzBIWgKwofocnWsTI77azJvFDLtDAjH0Mr8SHAohX?=
 =?us-ascii?Q?mRYokHONKkQSqCcceH6tLyNoCE9fbB4j9YJugYGlEpScTFnbZxht3R6x+JM4?=
 =?us-ascii?Q?odTvvi20ifisIJgt1j8b9j6R920wDOSy1RnDNly5R8LtEPIvZK8t54YuPAgr?=
 =?us-ascii?Q?s3CX44NFFmMF6Ay6xhmYV6CNau7arURzYhq6rZpW1KC8jx3dZS/KKLAzU9m6?=
 =?us-ascii?Q?eqga6OKFlCAMu9bHW3LBe2t8Uqt00AWkOaLlVSISfsqGjj8xk3wnK0S009lE?=
 =?us-ascii?Q?WZkjrFVYpTy8pokeGCfGFyKaafJdznJPUp4cmhDs+20G4i9H9ENLu1DUd3nO?=
 =?us-ascii?Q?TppsIplSsbLATUGo14T5A3FVJc5wRnZHPQKCdXeWtYokok8tVNYv3R6Mjbvc?=
 =?us-ascii?Q?rrDy9XcL3MmcR2SvHhx1HkatTR9N91ZQ8KapMgyRmlc0dYuN2W12PIZ2c2Lc?=
 =?us-ascii?Q?/iSaRMfy0OS38B8J3rgy7u+ypHkRXqezIR3+ALcymlnZKciPQ0CoVP65iObh?=
 =?us-ascii?Q?7Kc6KH4ecTQ7PPVi/pKO7Rgc9adtIb01s4nsDBHmNA2ZlWYLldUudt92D2WI?=
 =?us-ascii?Q?q5MnsmZqfhEuvEObp3ULQNjZ3NNlEW9L8Qt0CBiwQf7Z3R/Y+bq2m9cljqRu?=
 =?us-ascii?Q?nJkmgGx9O0XkNdEWT5OTonE9w2yVRssa0sshObZ/VOXZtfS/HbRXI/wIWBgW?=
 =?us-ascii?Q?PLJ3RDvydGOzcTk70aMo5HlnVWwf8rP2j/SN+R/RpMaEWb120a/ZEr8M+75e?=
 =?us-ascii?Q?+VteLfvZ0XbnemSOZIVBKDc3wdN7N8LEnWUBsOUw+2NUnODjuO2eECDvRXbJ?=
 =?us-ascii?Q?eTaWVi3JTC0rN2vBgcbePwEu7ukQBa5vJn6JmPmxVEudNiAcQRvaMM5lgKZn?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2F7DAEAA1853F4BA7A7127DC247C9CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NHQXKSw1P91WPwPxi4NuXia5FVaFWIlGfqANhRb/r1oHEQtitrqwl/+jG34v/4xpQsaMQV46M1Y3o95eQrWNAgC3f9OdyMoxFzod9ifA/nInVFVG6YWokNxjabWABlfQTMdzBZAFnGJFdpcQKVLYJ1Ag2zw+wv0EgyRY181a+QfGVB6VfIsFuyo7E9T990HLcfVjX9LLbDeyeIyF5m4n+SLShkfPXyEI4mKkPtbFz/OjmhDg2zsQBdITpkydxfSvWBZfQpOKrjp07lJvUL9vObN5p2oIfpjFLE3veRUlvRWUoIiq/61hQ0dAvnTfgZ39im2OgYaY9wt1WZzLdYxUO8ueCuDiFRcthVHJJtciMpRWYN1KjFcIVKew8xFcP4dSIUYpMO+6k6/oqBWVD6ib3l2ttJZis0BohwAs6BvbE2lyMpGYx5yqOHvcTcYHpyTVHm87TtzoNQac8/oRgzVkiBkUR5Np9E9XS0BFPLBW0Va6pi285FhaHifZTxqz2DQXOGus08XBqF69eGB3dtQ6vYe83fNrPvyTaCxginP+SFp7QNosJgXbP8cjnrNGzEi92WYkpFggojVIsEa1gvygbedNViQSRGYnnaiMZA9npW3ekiQGoeVmJBf5j7cB+HYFTNLzbCvqkBxf00ZtD36xKk3B8uUsjmpNy1HU0qiqTQfbhj+rrfGnkmaMKByFNFyk9FseMPSTJBjVDHXk7V9mLzXazDuvczTWnDEKmBkFxDSQ2r38M4aGBb1stCK1YJMSMliHUlHU3cshn2bMSpCobO0YjmHiTuDbt5TxI+EPmdSJrOGQJnCEPI1GYvoXmH4hyb8fJoMquAhZynFrhGXhGw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da5e73e-1ed0-4a40-1458-08db0d5ea459
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 01:07:13.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mf3bSa5BmRQYadcFxk8N03AbSjcQJKvZi4iwvypHW89EDz6ERhI8/aGOTcGGAzc6XA4fuTBmOPLhI8FHv/LVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130008
X-Proofpoint-GUID: Ai1jdOyouLBywn33Uj5mbycBIQwtwOUi
X-Proofpoint-ORIG-GUID: Ai1jdOyouLBywn33Uj5mbycBIQwtwOUi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 12, 2023, at 5:45 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>>=20
>>=20
>>> On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>>>=20
>>> Hi,
>>>=20
>>> question about the performance of sec=3Dkrb5.
>>>=20
>>> https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-=
impact-kerberos
>>> Performance impact of krb5:
>>> 	Average IOPS decreased by 53%
>>> 	Average throughput decreased by 53%
>>> 	Average latency increased by 3.2 ms
>>=20
>> Looking at the numbers in this article... they don't
>> seem quite right. Here are the others:
>>=20
>>> Performance impact of krb5i:
>>> 	? Average IOPS decreased by 55%
>>> 	? Average throughput decreased by 55%
>>> 	? Average latency increased by 0.6 ms
>>> Performance impact of krb5p:
>>> 	? Average IOPS decreased by 77%
>>> 	? Average throughput decreased by 77%
>>> 	? Average latency increased by 1.6 ms
>>=20
>> I would expect krb5p to be the worst in terms of
>> latency. And I would like to see round-trip numbers
>> reported: what part of the increase in latency is
>> due to server versus client processing?
>>=20
>> This is also remarkable:
>>=20
>>> When nconnect is used in Linux, the GSS security context is shared betw=
een all the nconnect connections to a particular server. TCP is a reliable =
transport that supports out-of-order packet delivery to deal with out-of-or=
der packets in a GSS stream, using a sliding window of sequence numbers.?Wh=
en packets not in the sequence window are received, the security context is=
 discarded, and?a new security context is negotiated. All messages sent wit=
h in the now-discarded context are no longer valid, thus requiring the mess=
ages to be sent again. Larger number of packets in an nconnect setup cause =
frequent out-of-window packets, triggering the described behavior. No speci=
fic degradation percentages can be stated with this behavior.
>>=20
>>=20
>> So, does this mean that nconnect makes the GSS sequence
>> window problem worse, or that when a window underrun
>> occurs it has broader impact because multiple connections
>> are affected?
>>=20
>> Seems like maybe nconnect should set up a unique GSS
>> context for each xprt. It would be helpful to file a bug.
>>=20
>>=20
>>> and then in 'man 5 nfs'
>>> sec=3Dkrb5  provides cryptographic proof of a user's identity in each R=
PC request.
>>=20
>> Kerberos has performance impacts due to the crypto-
>> graphic operations that are performed on even small
>> fixed-sized sections of each RPC message, when using
>> sec=3Dkrb5 (no 'i' or 'p').
>>=20
>>=20
>>> Is there a option of better performance to check krb5 only when mount.n=
fs4,
>>> not when file acess?
>>=20
>> If you mount with NFSv4 and sec=3Dsys from a Linux NFS
>> client that has a keytab, the client will attempt to
>> use krb5i for lease management operations (such as
>> EXCHANGE_ID) but it will continue to use sec=3Dsys for
>> user authentication. That's not terribly secure.
>=20
> I noticed this feature in this case
> - the nfs client joined the windows AD(then have a keytab)
> - the windows AD server is shutdown.
> then 'mount.nfs4 -o sec=3Dsys' will take about 3 min.
> because there are 60s timeout  *3 inside.
> but 'sec=3Dsys' does not need any krb5 operations?

I would expect some bad behavior in this case: the
client is using Kerberos while part of the network
service infrastructure is not available to it. It's
going to hang.

If you don't want sec=3Dsys to hang, then either don't
take the AD offline, don't put a keytab on the client,
or don't use NFSv4.


> maybe we can have another krb5 mode, such as 'krb5l'
> - the nfs client must have a keytab.
> - krb5 must be used only when mount.nfs4

It's not that simple.

All mount points on that client of that server share the
same lease, whether they are sec=3Dsys or sec=3Dkrb5*. The
krb5 mounts must use krb5 for lease management, the
sec=3Dsys mounts may use it, but don't have to.

What's more, when the client reboots, it needs to re-
identify itself to the server using the same credential,
no matter which order the mounts are re-established --
sys first or krb5 first.

Or, more generally speaking, when a keytab is present,
even if the client has only sec=3Dsys mounts at this moment,
it might establish a sec=3Dkrb5 mount at any time in the
future. For instance, consider the case where only sec=3Dsys
mounts reside in /etc/fstab that get mounted at boot time,
but there are sec=3Dkrb5 mounts in an automounter map that
get pulled in when a user accesses them.

In other words, it's not a per-mount setting, and it has
to be the same principal and security flavor after every
client reboot. We picked an appropriate level of security
for lease management that meets these requirements. The
only choice is to use Kerberos if there is even the
possibility that sec=3Dkrb5* can be used.

It might be surprising behavior, until you realize this
is kind of the only way it can work with a single lease
per client. Plus it encourages better security.


> It would be more secure than IP address check in /etc/exorts?

Well, it would provide some degree of peer authentication
based on whatever principal is available on the client
(a host service principal or some user that wants to
provide a password for this purpose).

But then user I/O requests would use AUTH_SYS, which is
trivial to alter while the RPC messages transit an open
network. That's what I meant by not terribly secure. But
better than all AUTH_SYS, sure.


> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/02/13
>=20
>=20
>>=20
>> A better answer would be to make Kerberos faster.
>> I've done some recent work on improving the overhead
>> of using message digest algorithms with GSS-API, but
>> haven't done any specific measurement. I'm sure
>> there's more room for optimization.
>>=20
>> Even better would be to use a transport layer security
>> service. Amazon has EFS and Oracle Cloud has something
>> similar, but we're working on a standard approach that
>> uses TLSv1.3.
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



