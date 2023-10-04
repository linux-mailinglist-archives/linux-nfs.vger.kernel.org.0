Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182967B80CE
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJDN1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjJDN13 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:27:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA1A9;
        Wed,  4 Oct 2023 06:27:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948j9ao012175;
        Wed, 4 Oct 2023 13:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1stPSEHW+dzoDTpLVOZfIE9rNjPQaCrrRxa5BREAVCQ=;
 b=0lsK2JcEkT4o7cb3i1qqYMfrNvJKvWB+HdVppTOpQ4g04oyRun1WTBV7mvQLczZl4mfB
 jP5IF0CrqAHfsNbv3hO/4qX/gnUD4lfejKkE3o7rk4aXzrNEyyZgPMindG1rnwENd7oV
 0ZoebGxXVnOZnx76WX9K9saaucO3L2gYYD8QvquKGY4oVSq963PNvL8B5jgla4YzYiC8
 CVFmWFlTbyV3yX6BuJ86fMSMpTAEuN66CzbkMzJb6IDdZMDSo3Vx/Q4Voi2ikVYwxcP9
 iGwCOEgHiyGQvXWx82/Fvpc9ZZy6KqUrpG2D+SYF3H6zY58hdGn6iiHQNSyl1imOwVeK qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vf07v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 13:27:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394DM2dp000483;
        Wed, 4 Oct 2023 13:27:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47gw8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 13:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfdGg+JFWpsH7oHh7xOGcJgU8U86MrTlqrAzJ10BEYi554+HW92tZqc+JH5N6qMwFdFgEgqdu+lYmYzs2oHQ3Gv7ifkAsEre2I6hIVQ8f8ql26GqhdpUQWWsKOClCB1cIPbn2vxXRH+lD3jsTu9kgdkCdrtZQenDQa/ht95AZJmFwUo2tHUzyCZxIQjC67wsWyicK9DcAkM6bj84L/MGalNMGg1yDg1rAl1X+/+o8MGtyplwO6lAkyRoyiTrKDVmWIbU6w6DLTPTx2dgblW/sJfhPsOMtuUbkdSHvnle96ie0Pb+D0HR168xDdLCCT4LXMbP4HnMUN+Bgmq+kdQKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1stPSEHW+dzoDTpLVOZfIE9rNjPQaCrrRxa5BREAVCQ=;
 b=NtggnsNVH3vs00ZpV69v2nWbw1iJiBHPIchO7jQauNOAd3EiSvXmFdLBjzZn7133gzwKfZkSWp5sBPR/0PGqfygzxTzA8fZjyf2KQADHpyMGiWCW4aT5A5WOVYC9i9jkFg3qp94tXzkVtuDIGiMuQlJhQRQflroBC3wcICKwo3Y39vkBvAXa1ruMOFOiZQ2QOLSJ8LU1nsDlOIK73IlT8V+yu/y0gX6Up2y2pWLtJtREPn5dcZc9OBvFnMuqao9niC4v4x0ChfURrmswQxl0aGnJlU6tk3MD0ppyjkCcsKMzfOt5Y1lSpuAuWn9UCoLACzuxN9jtO8tQz07PnVQr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1stPSEHW+dzoDTpLVOZfIE9rNjPQaCrrRxa5BREAVCQ=;
 b=fbHB+JzYxqPZoiJjP5RgCWXh18Y9g+tWWHiiWewV0sO9JXw7TYuDGtg50uSQlfUd8GEXcXegXtiEsI71eU7T5I1FCBsceoxqojhJS69ttsiUzaRF7X9r6iHB4HchradA/nsl1Qrng+sQLkRwHIg/K5PYJ3c2OBvs4FffbRpjUDM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5401.namprd10.prod.outlook.com (2603:10b6:510:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 13:27:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Wed, 4 Oct 2023
 13:27:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Thread-Topic: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Thread-Index: AQHZ5K6VPzxSK7yJLUWv/wHoLPVEXbA4fpgAgAEPLoCAADXKAA==
Date:   Wed, 4 Oct 2023 13:27:15 +0000
Message-ID: <6A47BDC7-FB73-4799-BC6A-9C0C020E424D@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20231003110358.4a08b826@kernel.org> <ZR07CYtL8GwMQQPV@lore-desk>
In-Reply-To: <ZR07CYtL8GwMQQPV@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5401:EE_
x-ms-office365-filtering-correlation-id: 86fa96c8-300a-4117-1308-08dbc4dd9fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXUGQu60Lm1KBHSqpUBTZZ3G+tmQtMIj4aqr5zWmV2Jqzw4HaekRJMhu5aYErnRlLJaJEfMMYLBR4/kilGwYOMxrzjpBr18++UBcKuzdQRkmGA7jcJBTgw5HH5aX96V693ODCp211pLEm6KreOg+YxTv6ASaKP5jb9WbSfeJiRbleWa8vgPZ+18/bn2NZv3x95sP7ojj+/ucvF6HCdhDPW1KSn3IqcTQErF8INBrU8kPjbnlAObk8j9u+2xELmbCMH3vqIiAbsegN1z3iMdT8KAXa/MnKvz9bDX6gZDqKnfTXekE3ejNEj+G6zfF7Rb5SHNeL+I1W3Z9L5HA4x7bxy+nM2bs94MEktQo2QZOFXz8/WXUHPqbumOj1CR3ucrAWRRnN3nZ8iMQiJy3cu++psB0TNE1sT6rPbKT3r8pJgK7GKpy6oIPIWq4QWdrAzlyoTbQt47/F9RgrzkvikUJAQSU1/46XU/QnvYsa2xNJrs7QuM+OXAFtDHHk6SoPorem2tTp25fLburqr+LsGZD4c6p2NMnFlK15uN7pFoeOwwzPDiA0h11PFructZv0q4O52uWlrUBkYEySpDqrOiXaRJkytOl9VpUL9DKneReWOKFEzd3ltUrH7R+rKnNH/XCLJC1P2bl2bqQCRlZ323UvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(2906002)(4744005)(122000001)(478600001)(38100700002)(38070700005)(8676002)(53546011)(91956017)(66476007)(66556008)(2616005)(6512007)(54906003)(4326008)(76116006)(6916009)(66446008)(6486002)(66946007)(71200400001)(6506007)(64756008)(41300700001)(5660300002)(8936002)(26005)(316002)(36756003)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ainv+XGspqoc20x/5ewl1Jiw6IElrr8gMihB9fPnyjAWty3BTP8SOvDYRh6e?=
 =?us-ascii?Q?t65ZhJYkm20STnSVxpl0rIDtKw7RTKBpyPP62kxqWiDlIyHDVhNFHBW32Rp1?=
 =?us-ascii?Q?dfrt38ogTyNUvZ7n7qt/70UTvt/tA44NfL9pKws6VeRhAuVjl3JTo47kT2zT?=
 =?us-ascii?Q?4MSamOXLFU9/qlmJVLiun6RIEM3ExJ+Y/LsuY+FxcY7bpdK4O0ZyuO7Yubqr?=
 =?us-ascii?Q?NnegBeZuD1eKeFqUgs6nv0XcVlJhBQsaDAHMDPCfjVtEQ09G+A09EblYXZuJ?=
 =?us-ascii?Q?nrltxoTBrN1EsXqhFSi6SGbwh601tmzMGMhajD6UizrTM/MLdWSuMiqfyyCj?=
 =?us-ascii?Q?ha4S2/Z+SDwTt6GxI/hDkMNT1DZ8xN2CZZmiMN8Bnlx1Fw6mrKYcVAab4+LO?=
 =?us-ascii?Q?W2MyAAVdrrludba/DihDxmlPWuYbBlvzIR8X61DTnfgA34juplELtH4xLxlq?=
 =?us-ascii?Q?Q2Kofca+weTdk5nTruIoOUNNDxsuNeIPJFzEDHL0Rc1l64TbZH31bx7q6l2h?=
 =?us-ascii?Q?jlvaeH8hp40CliAqAVtuiLmcRVcdOMP/fE29FlLSVBJpArvIyQRxhwOTjuAx?=
 =?us-ascii?Q?iDlLQXuS9Rvb4PpoOqU6uiH/FIWgbWvCz9EqF1y9EYyJUjy5nkxD6kbjGQcU?=
 =?us-ascii?Q?h2RC598WmR6h0J4/szH7WbxnPqtlVQre7LoyyOmIvJGr3m1NAS6xMPoNXhtE?=
 =?us-ascii?Q?89CQKfeuh5Jq5Vume8Pzu3Vi/9tm6CUdhJbjpCVLd8kSumTbtzyY5qQPWSxB?=
 =?us-ascii?Q?k6TQLO9tPTEZISelAIx/X0RfvV6COUv35ip4p1b7lTzrUHz3VY/r++PnFqs4?=
 =?us-ascii?Q?6FVjkFK/ACq3O0X3vniaipbquDTFwWB4feGWAUVyoimOCDkjLwsWKvzOkX/c?=
 =?us-ascii?Q?Hlb4iyWQr1Vi9DruDwUYg8+NyHL55FK9ZasB0HAsaXig5mKgqSuj4hFHEILl?=
 =?us-ascii?Q?6Li/ewF38GVeLx55Ze+7jECki8g/62Rt3ChHB5T6jdyRYDkVn+ix5Imq8Vz7?=
 =?us-ascii?Q?/HeEjvjqYedhsFXx88fCHtQf5W/qJnbyg9UKa94JzQtGz7xNC+YD87VVv++D?=
 =?us-ascii?Q?dlXLaY/99QbczNe3F41EdO9XXJ9CjK6kGufeTQvK46gcernRj8FONBSVnHz/?=
 =?us-ascii?Q?gxtVPjc0rrkVm18vOqQEI4KnJjgSzuByqXEeR+M2HcFGqWhfuh/lcJZx/JmN?=
 =?us-ascii?Q?hNWXVfj+bz6KwLrl4FIzSf6++Kzc2E6ShrFoYcApamKF3qBlhpluIQa1PNtd?=
 =?us-ascii?Q?CE0Ie0uEEW8bvTW2LJAe7vNMIKmni4Vd6xKSmlHF8jFbSo7DUULrGyouJs/b?=
 =?us-ascii?Q?2glKtVth4S9juRsv44jJvrnN8FaaVv8+EONEOzufuSgsX06YM1xGMnqTIq1A?=
 =?us-ascii?Q?8zZGGS9mttTkfNTftLRo2WQHVZFp39ivHbA3UvhwzdooE4Zwoz+lKHzufJYg?=
 =?us-ascii?Q?avdHuL4OelwD+O6ZFM6V/Ro5SJLG/gUplrdAsWQEQQ1ybEBMDpcRXS6dhRfj?=
 =?us-ascii?Q?ays/TDZjcp3LSKbtqrPSWeMwu4FdHENMv38uNfNCcbCsq0W+AcrDO8XfBIPv?=
 =?us-ascii?Q?3SJ+BrRCAwWxrdEOh9iXR+9XOrIy57hyFFqAruD7JT/BuMpzDOaHrxFBZePf?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F01C25557522D64CAEEF782DCFF86EDA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dm0SIf7jjU1f8M60GP6pAd15THIWbaP8d0mT4EDC2dV/MW3dWSLvpY+KReduH5YnqfdcuSgaBy3Op6SEszhqxZCAD4lMRZBh9DjYDAlLMJcz0OXiaQdxHC2S0b1TQWfpI+I+az19eSr8w18rk2bEGYOVS34RVirE8qZHpWJ+0tY0eBqSKbpOdQe5M+nZXMruLMJ836iKZM9L58p6Nex9Fua7dHbeuvghRaL+E1KP9gptqAOnvlptU8DyCsfHwhstOgFqKDndzc7hXdPnAREc7BjhCp3FQLwVXRjvGEILZ0Ihoc37QbC0tKcLJROrCK0Ttk2nJywYadJOHisNVegowwSrmOWHbHMy4cW0tU/lgB8T4IFOGXuNs6scQXcPrrslkLRvNBmp8Id37q1Ap1tLdgalrLKBEW8fDH+eDOA3AX7RPhZRwWFMgZgcdPTVkBRHzL8feeK8bMWtlkfiH4iyBlJcBPL42PdmGSMzsME9mowwzLkKUJBPRpW+4l35f4C+Usz+wI1DivNIoXC0sNBXhJY+O4U3a3ELWhNN1tOsR+G9lZYOTlp4GTwu6FybWDgNcfH422DeQeGlejpHueNzJMjHQO/kI5dZYr5jqszqhgrRYs1sVkr5YI5YXMjK2jA2RWGynnO5No/mNJbgyLwXYZQ9Xcyl5ZuHmJXE6jm1A4N1xPYRr0Fdf7Z+SFqtKl4QPjGIYEunJzcIEsrfliUiKYdmVBMfVEL0REFn78K3cDz9I2WDVuklSkZpI4KAEyjEzM0hIrwWdaSXeHdooiMGvhW8t9NOf4bjmSFUEXqEPTprO/Yk6wVtt2bFIbAgg9r24+Jay+0FJ+9zR+EKherb8w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa96c8-300a-4117-1308-08dbc4dd9fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 13:27:15.1761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e19w8CWlNkisrU3GbXMEL/ptvWxHgytA5/2uN8LDjS0Xfk3vxeCiKK2nkTIvfnV3ojadv+qAKbvxEM/V/7swDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=641 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040097
X-Proofpoint-ORIG-GUID: IDI7jFfAowo4kWshPP-sCYiD07d99IcQ
X-Proofpoint-GUID: IDI7jFfAowo4kWshPP-sCYiD07d99IcQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 4, 2023, at 6:14 AM, Lorenzo Bianconi <lorenzo.bianconi@redhat.com=
> wrote:
>=20
>> On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
>>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
>>> +  &nfsd_server_nl_family, NLM_F_MULTI,
>>> +  NFSD_CMD_RPC_STATUS_GET);
>>> + if (!hdr)
>>> + return -ENOBUFS;
>>=20
>> Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
>> multiple messages". 99% of the time the right thing to do is change=20
>> what we consider to be "an object" rather than do F_MULTI. In theory
>> user space should re-constitute all the NLM_F_MULTI messages into as
>> single object, which none of YNL does today :(
>>=20
> ack, fine. I think we can get rid of it.
> @chuck: do you want me to send a patch or are you taking care of it?

Send a (tested) patch and I can squash it into this one.


--
Chuck Lever


