Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809B58932B
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Aug 2022 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiHCU1S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHCU1R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 16:27:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231365A3D7
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 13:27:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273JsGUm012719;
        Wed, 3 Aug 2022 20:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VvuIAMziuQsj2rQKab9h/ig7QTMJfkK6YAyXGlUsgl8=;
 b=XxxbzDXfl/VC5oR8Z92sExppZPA5ohwc4EASGKFKMgpQRb3Uog1A/HGuYmRIckvfxxG/
 xok+EP6MPz4jxVMWGHHzH+nNXcbAELPVr3RBT1eF19k6IKeW36vMFMSibVCkZ4zymWRi
 NwUO91TFEyh87pdO7fcA/eRQA/mVvzCQZGXAHfjlVQVp9rPyEplY20b8jjBk7CjwEAUz
 vjyWb3No4KPx6jxfEkyLFYou5cB4H9eG9ukcCWbGwp2+AoDJIb3w0rJXE42dpU1uVs8W
 7WOaXa5Ex9K+M987vjaSYgnbYoTYlTUXXPXBwN7TWbp3Fg7fYSzN0OXtyCBzDhHK8WW5 qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9ttk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 20:27:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273JA6Qn003010;
        Wed, 3 Aug 2022 20:27:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33nqy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 20:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeM0374HKZ/9VlGEQNZbWvb3HgOB7JJgv3Qjoqz7p3j4JIWtrsJ7xOlmZstoyMYqjCgzMH5Up34wwLEvtfzPdqdwfqgxMw0SCm9+o9u/zzbuamDWBXi08fL0niM85OxSXu4C+qdEm8wyu/ssZ1+cCyl4u5MXlZoB26Or0bPG0nCG/f9oEaxc4FwCplYK9US5Y4t/qXgZSKOjnb9nzN6blNk6MF3LZKFU9rAiXaba18KThfAdQ7wJ9ILrfXStsskp0BaqaXCs/LSOcPnVBlulU9tlhutI19ibFYhnqgdRnkn3hHZN7rzIki9XaPeGf6tb4rEHkGmFaGZXWMgz8f/dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvuIAMziuQsj2rQKab9h/ig7QTMJfkK6YAyXGlUsgl8=;
 b=Ygyq3LcEhwnx4NQKapKyuXTjb19yENQ0RuZJ8q244lyu7GVLF7k0qRSfZTsdsp14e1iQa125nzs7UrdUNN0kmjE+a+/qVC4px1hU9T2CR8S40jVjM75q13yhCKjC116inckGcv7WgmvOBpq/OmxeXw835pTn951tpucKo5KKqupdmA8DRHBYif0VJq3hsHbMJ82FqiW5c+Is8AijoYnrn/vsHiTJPqZqKDmO+OBODc0aV+9Wmu++E4Mzd+KW4iDptxdi4fLX7v22v+4YTQfMmCDgf/uWameTjr4a20AsfQcjKEK1iZAGGaa8A89Ff/Y56tVhsCCan8Qgis/zgw5U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvuIAMziuQsj2rQKab9h/ig7QTMJfkK6YAyXGlUsgl8=;
 b=FaKHlrQTtC8VCAkpLAqqFg5nD8GvaAmVY2J1nibXXpNup1m/9ue7iMafg5jGx+XPJJIiWR0Rt9pEQcO4Fk6kzY+oJfXaIL9Iga6d1F3l6rQPiIWst6rjzyzoy85MQDQYh8m1TtNl6ltvJKtrki1YQs5GIz2W7xmKN81EiFSPgcg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4161.namprd10.prod.outlook.com (2603:10b6:a03:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 20:27:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 20:27:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 2/3] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
Thread-Topic: [PATCH v2 2/3] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
Thread-Index: AQHYp0acIgjbwsAV+0uR2uzuA4pLlK2dlUKAgAAK9QA=
Date:   Wed, 3 Aug 2022 20:27:01 +0000
Message-ID: <7FDA1AD5-96CF-4E35-8AD9-E5B519E44FF3@oracle.com>
References: <165953688893.1658.15242150042289528147.stgit@manet.1015granger.net>
 <165953745991.1658.5781306176717145818.stgit@manet.1015granger.net>
 <7307aa68bdadd97ecbc51b40a2d3d4e92736062a.camel@kernel.org>
In-Reply-To: <7307aa68bdadd97ecbc51b40a2d3d4e92736062a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bbeaaa3-970c-4282-6e8f-08da758e85b6
x-ms-traffictypediagnostic: BY5PR10MB4161:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usLb7EBZ+sRcqhQStAPG5DI0171tJiuVyv90YndSs4sYK6KHbqmHOAYqXIP7ooNcRpD2QmXIGkJEcxZ024oT4t4ApztvoDy+tYdYZZsj8kgIr5bPSE5ncEj/WAXzI3jIu+l/UAujLieNdVghP/NSxnZZhKB97/8TCQug1YNjT0keA3Cplcs42EZCveRNx7uXek2ABcPkc2uQKFbme3onrzFHh0wxrTHDw4Pdl21Z2udZiJG2BAfq+Zj3JjlcUNwmcwFqb8CI8fB3BhFeVO62ynR8ecZPy5PCUP2jv1zRlrHA1vbhCsE+oKbILSdIW3FfjU1CxJe2x+Uk/D/7BqKYgJ+4FM6feKYk3d0BVRlj3SAVBpsOtLU90lIxlZLscPenRnpIrLcT18GbNnd5swsYb91DUjfhcjWR2UFWZuXcPSo2Cr1la+1bD1bzrf6hq+6taX+UBaKliVc5fT8oHul2n8uBt+5BSpwnMAMIAD40EyMYPJeMGwj8FFhLrfDIGOHTIhNwJF87zj72IAuxbD/ONC2/QyJTxFCKmvbwqIWZxABpGF1DjNk52UnFk3brymnZmvp3WQ8lWN/kGjOs5sJ4wvVMGTuxT3p4xTtl+YhmYoN9atJa5eICVGlU5Gs2c6cne4WrIMhZPJD896i25DHPckwkXFrgHa7bzJ8Se+5bUk/us3vEyUIdZ7f9UBbRYrV6r+MitNv11OFjKE2ds0at4pwXmVXcUzLzkfvQH+2iQB3lQLM+EWlE+gsed8qcx/ultwKIlywWHj5dOjaOdUZmqmvBpI8kQPEXfPPJJdNWsjgp2k4vrGwSWIEPQoS1yeMyGSuz4/m8nPvLqeIxqVrXJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(346002)(396003)(39860400002)(6506007)(53546011)(38100700002)(41300700001)(36756003)(26005)(33656002)(5660300002)(8936002)(2906002)(6486002)(66946007)(38070700005)(71200400001)(8676002)(4326008)(83380400001)(66446008)(64756008)(6916009)(478600001)(316002)(86362001)(54906003)(6512007)(2616005)(186003)(66556008)(76116006)(91956017)(66476007)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d3fXUpqfN0/iRAusSNvWgBgX3TKj/rBzkqidNPtFmw9KbLBPkpuBS2+F6pnK?=
 =?us-ascii?Q?sy4iQxUMB7K1ZXbynC/Ezw9DbFGlYPjbb+8vsq3V+p7vn5Y72LJ5c01cJQY7?=
 =?us-ascii?Q?lw/A6F21LOk96iAEbDuWr0QAuHfCiEDJMu9vDbKNzNY1zLsJLAZuQH5+vbH5?=
 =?us-ascii?Q?gH67ztkVoHa3lc5O49S3/NgzPOD7X6nFCCZRTp1nqkaH4/jtR+/JE3yWr/Dk?=
 =?us-ascii?Q?HG5rmjq1yltOXDhTItboGMkV7T7OR91K9GjhcEeM39FXDfJSjwLgHQYvw0pc?=
 =?us-ascii?Q?XVuIynK5buUr2IyAE4br0pK9RSjpVy1LiInQYykenDX9rqjZouE6eZhDobEZ?=
 =?us-ascii?Q?9rfxTm6zkgBL05mev+G9YOqy7t+Xnt2rn0Sq3QXh8jV/IQfsarBIVHmuU6yZ?=
 =?us-ascii?Q?sFoR3Gyd0pmjSWnhZdnJdeeS6lCXHym6R5uQyB63891yzhrTNFTpgOK3ty1I?=
 =?us-ascii?Q?k9jW6f6Ea5xqgy7mIg01vZBDYRJQbkSjfFtvlSIqsrhkCsW19NxCKAZUhhFb?=
 =?us-ascii?Q?nKKQ2F6jJ0AHjnucj2D4sAxO7sBEaRe4VGPLPyF3UwQgWSIxwGACGnOo+YYB?=
 =?us-ascii?Q?DZe4Qp+LMqhLu+rfZKq/ECXgZbSXWCuwaeWk9m4AB1PMZGtp684qI52Zf3yw?=
 =?us-ascii?Q?ET7w/R90oBmxQKgEFaC2fuPFVrTLF9vnpWYWyt0oamAnVdIB97S7L4BGJ7Kp?=
 =?us-ascii?Q?WxKrQZgy3zvtbH9Eidnpuuivxep2DsGzOpke3UAgBbmiH/4S2fLmcGHMwiBn?=
 =?us-ascii?Q?vJJb2NBFdXbpXzuPD2ro2lySTp6Klse+0sLDzT+LZMN3u3Ssp8gwlzNCZsQF?=
 =?us-ascii?Q?ATdzAsjOvve4IpgrutSNvjP1iZFVymzUf8P20z+ZS675scJuHUn/VkxyPYnG?=
 =?us-ascii?Q?OrozWhgcmZSG70IAU1BRpI8kjn+QxUAai2q38gdtygoeazGu2aFKMlEVpY/A?=
 =?us-ascii?Q?3AMx+ep3GgeHWtb7EASfp884p3ETOB+4pcDF2CyZc4PmhARUT89uuVsnUdGq?=
 =?us-ascii?Q?Ff8YhhRhAkOyxYdf5E6gCXy5V4nLcf5t9zPWY2dgYX461RNxl0Sy08SW4gt3?=
 =?us-ascii?Q?8PlWOou+yVAlxryHnHfOFeVAX9+IuyRUCp3D6oe0sek21hcgRX/9w89cwkpO?=
 =?us-ascii?Q?YM4xmeFr9cewzJayTNblHIAR8AM1vrJZVfk02paaPr6HeO4Oc3c7D0/OCMFH?=
 =?us-ascii?Q?7xt2LYPe/GKHe9Uti9JlhC/aGtkNrvS7QevkhvqtEUrFQ7K2fn8UmLobMaVe?=
 =?us-ascii?Q?XAf2QLZ2UxCkL2qgbzDGWJ97o3pIgis3MXVxim1kCJx2GPJS2+FYiWE1MM/9?=
 =?us-ascii?Q?KqUH05+sfwNTM29ZMATUTb94KJz7QFOFZpXPMNlE/WFgswAz5C3fZbctOS2U?=
 =?us-ascii?Q?Tt6QacjozFwm3nR168OzJkqz0X8BXqjhX/dE6n466pnEQlP4oNRGpjSi6HlX?=
 =?us-ascii?Q?7CzuJW3ojE9u6PyGuQUGzIjjiCDvghErpUxL5IKHWBdHQ5NGGQGRm1YlhCXp?=
 =?us-ascii?Q?c30HjPjXRaH/XZkOzkixMvx861biMiihMlJSA/ytHaxEaMm5zgWPQUx6kdSg?=
 =?us-ascii?Q?3haxZLaFRKASZRIYsBUSmSNqe7Q3++U2g42u1Gad+DdFRqklt6hQGrREk+c+?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0806B193BBDF184FABE5961D5272410E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbeaaa3-970c-4282-6e8f-08da758e85b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 20:27:01.5165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1+OOK3P709Kw/67tjANHH3RLh3X33GKiM0YCA+gs1hQcPseuPz1bWpHSCih0HiZAC4ftYR8PuIqJVnSkfcCBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030085
X-Proofpoint-ORIG-GUID: KC1pc963C-X_W8WzMk7IPsq_roCzWPJq
X-Proofpoint-GUID: KC1pc963C-X_W8WzMk7IPsq_roCzWPJq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 3, 2022, at 3:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2022-08-03 at 10:37 -0400, Chuck Lever wrote:
>> nfsd_setattr() can kick off a CB_RECALL (via
>> notify_change() -> break_lease()) if a delegation is present. Before
>> returning NFS4ERR_DELAY, give the client holding that delegation a
>> chance to return it and then retry the nfsd_setattr() again, once.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4proc.c  |   18 +++++++++++++++---
>> fs/nfsd/nfs4state.c |   17 +++++++++++++++++
>> fs/nfsd/nfsd.h      |    1 +
>> fs/nfsd/trace.h     |   19 +++++++++++++++++++
>> fs/nfsd/xdr4.h      |    2 ++
>> 5 files changed, 54 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 42bfe0d769ec..62a267bb2ce5 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1142,7 +1142,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>> {
>> 	struct nfsd4_setattr *setattr =3D &u->setattr;
>> 	__be32 status =3D nfs_ok;
>> -	int err;
>> +	int err, retries;
>>=20
>> 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
>> 		status =3D nfs4_preprocess_stateid_op(rqstp, cstate,
>> @@ -1173,8 +1173,20 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>> 				&setattr->sa_label);
>> 	if (status)
>> 		goto out;
>> -	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr=
,
>> -				0, (time64_t)0);
>> +
>> +	retries =3D 1;
>> +	do {
>> +		status =3D nfsd_setattr(rqstp, &cstate->current_fh,
>> +				      &setattr->sa_iattr, 0, (time64_t)0);
>> +		if (status !=3D nfserr_jukebox)
>> +			break;
>> +		if (!retries--)
>> +			break;
>> +
>> +		fh_clear_pre_post_attrs(&cstate->current_fh);
>> +		nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh);
>> +	} while (1);
>> +
>> out:
>> 	fh_drop_write(&cstate->current_fh);
>> 	return status;
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 0cf5a4bb36df..e3ac89d4a859 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -4689,6 +4689,23 @@ nfs4_share_conflict(struct svc_fh *current_fh, un=
signed int deny_type)
>> 	return ret;
>> }
>>=20
>> +/**
>> + * nfsd4_wait_for_delegreturn - wait for delegations to be returned
>> + * @rqstp: the RPC transaction being executed
>> + * @fhp: filehandle of file being waited for
>> + *
>> + * A better approach would wait for the DELEGRETURN operation, and
>> + * retry just as soon as it was done.
>> + *
>> + * The timeout prevents deadlock if all nfsd threads happen to be
>> + * tied up waiting for returning delegations.
>> + */
>> +void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp, struct svc_fh *=
fhp)
>> +{
>> +	trace_nfsd_delegreturn_wait(rqstp, fhp);
>> +	msleep(NFSD_DELEGRETURN_TIMEOUT);
>=20
> Like you mentioned in the cover letter, this is pretty nasty.

Right, it's proof-of-concept stuff.


> You could use wait_var_event_timeout here on the inode, paired with a
> wake_up_var when a delegation is returned.

I was looking for an NFSD-specific data structure to add a
completion to, but yeah, I guess the inode itself could work.
I'll have a look at that for the next version of this series.
Thanks for the suggestion!


> For the condition, you could use something like this:
>=20
>    !inode->i_flctx || list_empty(&inode->i_flctx->flc_lease)
>=20
> Maybe even a similar lockless check as the one in break_deleg?
>=20
>> +}
>> +
>> static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
>> {
>> 	struct nfs4_delegation *dp =3D cb_to_delegation(cb);
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 9a8b09afc173..0b800a154828 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -341,6 +341,7 @@ void		nfsd_lockd_shutdown(void);
>>=20
>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>> +#define NFSD_DELEGRETURN_TIMEOUT	(30)	/* milliseconds */
>>=20
>> /*
>>  * The following attributes are currently not supported by the NFSv4 ser=
ver:
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 8c3d5f88072f..dd2654cac132 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -443,6 +443,25 @@ DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
>> #include "filecache.h"
>> #include "vfs.h"
>>=20
>> +TRACE_EVENT(nfsd_delegreturn_wait,
>> +	TP_PROTO(
>> +		const struct svc_rqst *rqstp,
>> +		const struct svc_fh *fhp
>> +	),
>> +	TP_ARGS(rqstp, fhp),
>> +	TP_STRUCT__entry(
>> +		__field(u32, xid)
>> +		__field(u32, fh_hash)
>> +	),
>> +	TP_fast_assign(
>> +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
>> +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
>> +	),
>> +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x",
>> +		  __entry->xid, __entry->fh_hash
>> +	)
>> +);
>> +
>> DECLARE_EVENT_CLASS(nfsd_stateid_class,
>> 	TP_PROTO(stateid_t *stp),
>> 	TP_ARGS(stp),
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 7b744011f2d3..5b9213076e95 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -788,6 +788,8 @@ extern __be32 nfsd4_destroy_clientid(struct svc_rqst=
 *, struct nfsd4_compound_st
>> 		union nfsd4_op_u *u);
>> __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_s=
tate *,
>> 		union nfsd4_op_u *u);
>> +extern void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp,
>> +		struct svc_fh *fhp);
>> extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
>> 		struct nfsd4_open *open, struct nfsd_net *nn);
>> extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



