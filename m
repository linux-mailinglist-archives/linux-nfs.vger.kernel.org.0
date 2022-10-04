Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC05F443F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJDN2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJDN2X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 09:28:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFC25E1
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 06:28:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294DPUn6009821;
        Tue, 4 Oct 2022 13:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KmqKwm+L2Z7bra4cIQd+caafqHpjPpML6qL67bp5RmU=;
 b=ny+mUPUzadMqpGqU8DzMHZz8BM+C/0UeMePQ98OambR5onLbZpgqJDcIOy4ARaKlZDUJ
 R6R62maO/1FeqZaDReq43Uf/KyAuxNli8/117i659/yV6DNcf7R/ydc6t+eDbSlDIMLV
 Yv4N1G4Qw3fvLYQUKocmBy6yAajHOMKuRoiDFz6Ull+w/AlXFKF0f11PO9qs4QUuFqzB
 8CZUucEV9QN1OFmZCkGtEa6ZAtYM6cRG+FO0FTIRLWloS1D57jok59CjcDTG2YAh8rOV
 O3X3InCeD/q56ZrhV89cFScJRmuHpuKXD2N1ki7gH2V3svFnZWmHnm24BMP5DSezZt+r pQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2pdqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 13:28:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294BejY2000964;
        Tue, 4 Oct 2022 13:28:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc04e0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 13:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISuL9eewbNsLPVzIkZygD1o1WtH0ij2HVm/lGiVOJkZOjVud4vwy+qU3iRy++QyIIHSFITbl37oLuecWfkO3m37SyU5/QNnPpYh587Ho+pd2VkvyyvCexE3ZETDyGZUyfZ6ZhUqIIotB7ou849Nc/M7HM0YzhZ2kYFgoDZAR+T07cbZPPXOfusAh6bddQHx7NwfBNLsd1ILnGXIp48zDbXh1oFmHw/4e5u7sbjTIl+Sz10I/eVgLsAoeSOelgMJ/ckwvrrDILOjTknc/CAOoTbXtnBitnTgSx8o43b5up9j+blHgcXtFa/8eYahcXIheIyJzV0myeyJSsRo7jB8O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmqKwm+L2Z7bra4cIQd+caafqHpjPpML6qL67bp5RmU=;
 b=gXjhy41ULOxMEqctL3Gj8veBpPPsx76w9BmRN7nL1Uf0+H94hXmQKWV/lhRm0Mvf2mwRlOAawDY5X+OLG3LMPINCCyMpJlZkqu5TC9z/W6Dk2DVFfZgGaUr4cpWFxmrsr2ApP+EVwKCmAJwVYXtA75gp3aQu5NeKuh2K9yhVqChaRw7uGCDzUpE3lTz8nbnAYtEAzjVOaft34mhj08CqosCQUlPLOYGtXtSJRejwo740NhAzThr9HvpOtKI50oQqX3Sl+yvesrtxizRpi741I6zZugxSR3K6XyPAi7Jkz+zbUguLM4j6jKGXh8kPLMFPnIfQog1v+Gv1SQAb7JWESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmqKwm+L2Z7bra4cIQd+caafqHpjPpML6qL67bp5RmU=;
 b=YWqlBqU3P0OzIkEmTDlONpA0Gxtx0ujhtvW+panDB070X1PW8XBRO4CQgKmH7rzkPBLmANv+BoVaeqjq9DmyUrbPMNZKJ7Lue1YNWxJJAX4eh3pub37+562CjnsLgoVkaT+Lv8YrE8dA3sCu/rrZMrtaaYHYn/qmryCOWPJKkMA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4726.namprd10.prod.outlook.com (2603:10b6:510:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 13:28:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 13:28:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Topic: [PATCH v3] nfsd: rework hashtable handling in
 nfsd_do_file_acquire
Thread-Index: AQHY1xwiPOG/BlB/KUiRs5xLTvyF4638pTOAgACVooCAAQE+gA==
Date:   Tue, 4 Oct 2022 13:28:12 +0000
Message-ID: <4FF85113-6F17-4F3C-AD31-E2472A988618@oracle.com>
References: <20221003113436.24161-1-jlayton@kernel.org>
 <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>
 <166483484979.14457.9448463531121052564@noble.neil.brown.name>
In-Reply-To: <166483484979.14457.9448463531121052564@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4726:EE_
x-ms-office365-filtering-correlation-id: 407962a0-950b-43e8-ba5e-08daa60c4914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJpU7H3cWdwyGMHwVo58rX5Epc4HYkE4e4Pc+e/izFrGI0d2/40dQqpcI80682cLZh4Z3mD7BgSO6wAcVFswfR80+HkJLUHF3OEk0JJQvedoHO/f+YxzNtrYOSuFp4qVfqTDVMPZkL8d6a6uYKSHXHDszsK5WRiuHsLjDvSnmhGG3+fk5SWs8AkaB/qCiyJqbFYcvDu5IzPbZPVN3Ph8FxFU9sAGahPGrmYMTlzx7c8DPiuO/Qu3pb6KEu6ne5Ivvsc0V2bo1g7izDzm5Z84MTh1BLqX/QyQvlU6ZXKPAcyHqIrWgQMehS2xcg283sg6fLGxDkEHu6XNE8v49P2nK6W6Viwv7eqeni+v6xoIA93eiTDkRcS8iBSoSAX4Ryfo0UmVhf6FxcHmjSc7XMcgZYKO1/9k3HoSPvCAPhRD4YOUVg7g6YWbCJhk8J0xfIiGsOsR7IR3uV5M+QFSTkDMz9Wzo/CsnwBS3AfirXjWbalkwNRbrTkn1oxTTOZrMN5BxUYFn93E3ztWeJ19hYYQKoaMvaT23XrsYoFxkBkS2+AdZume+h9XgwU9WePSHBEyko9MlQ2cI2qPokN0jFDlfmF9IvyvbddVNg2tX/N6WeUAnWMhClyeFS0jhbU1negDMGYdfC+tbH2luXShg89BrcnGgXk5CSiuLJiY/loGbiwOPyLvyNcQg0oubfP+dqVdwDx0GYVQySArlMmSZoz+KlZxxPmcq64bPaNusqvclR295FGWHvPM1JNOhi+wCZAZUpSV6BR6zaX3qsBV9eHF48jE/rsbw8HVEiiFreOCwQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(5660300002)(2906002)(41300700001)(8936002)(6506007)(53546011)(54906003)(26005)(71200400001)(83380400001)(86362001)(478600001)(33656002)(186003)(38070700005)(91956017)(66556008)(66446008)(64756008)(76116006)(8676002)(4326008)(6512007)(66476007)(66946007)(2616005)(36756003)(6486002)(6916009)(38100700002)(122000001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oo/egr1FyirwGm/yPjishEdW/KdTfapopvH5RnGcSE1Z5bWTPGYV0EVsZov1?=
 =?us-ascii?Q?ODlD1VSNticOMC+5UfJyprQBnovOU7ipsFMD20mULTUIvm9hxbvVM6AD9mzy?=
 =?us-ascii?Q?WlxcHYnmC92De3lGdi83Q9kStOtpzXd2ivcAqzjygRJ74NS7V63lf5wmvhJx?=
 =?us-ascii?Q?rOr/JJEaKHIIatwAkr4NpjHEpZzdakRRnkqZAtEqLxeNBnSRpi/OPJEkActV?=
 =?us-ascii?Q?4rl+am30mzIFcyU5J3RWjm52NQ40lqpAXd5rjS6kNslitAXIgw8TbxmPurWU?=
 =?us-ascii?Q?A5RkoPmX6I+XLWiN7XHbXSd/ykgFaclgmCZ3yWKCuBVtqDQoQpcH/1mlv2Kp?=
 =?us-ascii?Q?bz65FIaZuQfPjn3m23NmRHZqhzT3ISDYCod5DDTQ5ZhMNA8ZpIgETOa2zHed?=
 =?us-ascii?Q?8MUH/lNxjdtTPgrwJnQVeOsBpkbGDBv89Db9hBjA54GGFdS1TDEZIkbd//9w?=
 =?us-ascii?Q?3uUt3oxmamaIXIvhe3jXHTcAYXStYOtw2tb48JOb0Lz88TVj+Ru1+9b5Ltea?=
 =?us-ascii?Q?/4orik37hSdzlfPkyJKEiBjlU3YloeOgLOytoeX7W1ZACgtlJbZnv5zNHrYN?=
 =?us-ascii?Q?6W/EqH/6TDK4sB47jIrDAjY41fkRGKt05qiy/nkOZu5f8PU20a+mVj0Ruorf?=
 =?us-ascii?Q?ryuyWepLThZQmCh+PCAB8OmaCTYORBN9XwoSbLKSEPeQadc2a584l+kErUqH?=
 =?us-ascii?Q?s5SC8P4TOfXB2+wLVegSzJEOOkz+hWCdQxqjI7yX2U4BIgK6ko0TWlx0gHX/?=
 =?us-ascii?Q?EDabetM5MK6n0z3ArL5jy9gGfJEwsOuHC3Tni+IEVbr1SmP2ilKsWxJqD/pk?=
 =?us-ascii?Q?GKNykqEYNt9bK7yzAoXTtVxNrZFWkOoXApojQEWblZ8CoMm1pjvo7oKdg6PA?=
 =?us-ascii?Q?6XB//GTeOnDboOMMiXydBBYOCdYLUds3VdVI+VoHHTdofVCdijv71ShctSKI?=
 =?us-ascii?Q?Fwpmx+waL3hLskxlWjSiG0Pi4Vp09+RdcVdnKxL2z3M7CFLU/I8gLxteazx5?=
 =?us-ascii?Q?WnPYk38Qge76Kc9GdfpDQUD5kpnHkwGH9mXAbspTqK/nZoQPCvPdDmIniLOJ?=
 =?us-ascii?Q?dbsjuwiEtvZFV5UeRU8fAlEE61dttF9C3V2ZQIN514d4c8M5uozf8x2QgZsF?=
 =?us-ascii?Q?vdIK71Ojdki5G3XiH0JMuh4bk/e7lH3T9uJeKOcDnOMgInSmhkO5VXifg1L6?=
 =?us-ascii?Q?oIal8YhVvv0x+nsBAWwDiBpv4wEwrthfKDiAaQD7v4nKjq2SE1MeEMSgWXAU?=
 =?us-ascii?Q?6xOHT4/rjRgykJLQgQgDFWDCaPL8nKdp9ZYCkPGIaPdF34BJu7g6s7/EJKpR?=
 =?us-ascii?Q?lyJnXfKfLm+F5yP0LMmni8eAnqQm4jaSyUDjuaXV8jCux4bgN6YxDWRWl2QF?=
 =?us-ascii?Q?Zl3rcR2FvuPSiT+rvbRRNP11ggnd8mFpMndqXCqTCRspUho/Q6xKqoj5QQtu?=
 =?us-ascii?Q?elTErvgt5cswELeBKb3f+ud4MfPq/rqI4BKpSTuNjckZpX5DuWJk9TSSgIlf?=
 =?us-ascii?Q?FzD9ga2HOBHpIdf84uRrUf9S9ZRfN8uNPPeM4pLysNzw+3+soZgvPzZb7BAx?=
 =?us-ascii?Q?sIzx+zQ6tXMxW6zyvkXr6iCxzRdGSc5NoES2nr4IQ4IWnXobfhy3XagjtMN6?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1C0A7F749171B43BC4D46E93619DB04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407962a0-950b-43e8-ba5e-08daa60c4914
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 13:28:12.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFNznfWsl4K0QKPXDoJypwoWfGXuwlCM+nj1Vb3Hrj7QnujelClNN29YFi5qNUTFhjl+CXNLrd2dv7R4P1Pg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_05,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040087
X-Proofpoint-GUID: yMY6eBIHMYYfRAAxRZ4PH0hLC27BWPTj
X-Proofpoint-ORIG-GUID: yMY6eBIHMYYfRAAxRZ4PH0hLC27BWPTj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 3, 2022, at 6:07 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 04 Oct 2022, Chuck Lever III wrote:
>>=20
>>> On Oct 3, 2022, at 7:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enoug=
h
>>> to get a reference after finding it in the hash. Take the
>>> rcu_read_lock() and call rhashtable_lookup directly.
>>>=20
>>> Switch to using rhashtable_lookup_insert_key as well, and use the usual
>>> retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
>>> target as well.
>>=20
>> The insert_err goto is there to remove a very rare case from
>> the hot path. I'd kinda like to keep that feature of this code.
>=20
> ????
> The fast path in the new code looks quite clean - what concerns you?
> Maybe a "likely()" annotation can be used to encourage the compiler to
> optimise for the non-error path so the error-handling gets moved
> out-of-line (assuming it isn't already), but don't think the new code
> needs that goto.

It's an instruction cache footprint issue.

A CPU populates its instruction cache by reading instructions from
memory in bulk (some multiple of the size of the cacheline). I
would like to keep the instructions involved with very rare cases
(like this one) out-of-line so they do not clutter the CPU's
instruction cache.

Unfortunately the compiler on my system has decided to place this
snippet of code right before the out_status: label, which defeats
my intention.


--
Chuck Lever



