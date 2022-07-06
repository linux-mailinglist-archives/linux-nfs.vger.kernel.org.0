Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200A2568B49
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiGFOdl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiGFOdl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:33:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F513FBA
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:33:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E4aoN009659
        for <linux-nfs@vger.kernel.org>; Wed, 6 Jul 2022 14:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xe96qnYdAo7OiDGyMscuV+q9d3OmGU8/Hy3CPlO1rB0=;
 b=Hy3xHS+mEPgwqfhzBANFvq+pY3XE3//1Q+DBUXZQYd5FLcNTrEhiZcKdeyRW+po/Yhn/
 INGgKfry/1ekhRtzZ7UaJEX9g1NE0FLalteMpLFx4R1U1+DQ1434veVi6SI09oz6vZeV
 iXg9nkhZLY5cr1h43bZSLz2VuRGJIvOONBkpr5lnRDkVas73lgOHrjL5w569S40r0xFo
 SqlQ5/CF7gIVbgbRcWCP8WS09sy0vUalSnudKTORLlpWOEh9yow+XTEGa4p8fULCYe+F
 HGKksOUJ+xcj3+b6hjf/D8coJJGWb04yBZuUFyyO5yQJq6nPzlcFFBygdRJQdvSvABON +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubya6vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 14:33:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266EFR5f029083
        for <linux-nfs@vger.kernel.org>; Wed, 6 Jul 2022 14:33:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud83xfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 14:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW6JtEE3JFaN/V92Oo4OUp3oo1BT/urvWw1l6tkvOLAGUIASqKNkm2G2iRtHGsvTcPX3W37ZW8VC1jiUqreu3B0DIivuF4NiGmxk08/t5tnMgtfQkbPYzplUOV9mGcwDoDgWkKWP5I5A3GWRlyzo5hnVqn8OnWJHjh4VaUNxjBX89RowGzzq4zTEHeuTby2zVyhErctS7NMxu+WP7/AtSJxP350an8892jv2AQOUBeSxzZ0Okzxowrs8JXRzSH+vgTa5T8w5iY6JLoEz47HUsRTy1E0aQMHCZKdmSYrFdaheg3y9sPbk7nuoI5YNzbvn7vaMqylVOOd6Za9vEqjKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe96qnYdAo7OiDGyMscuV+q9d3OmGU8/Hy3CPlO1rB0=;
 b=E1kb7yF/MZ/qHc/p7RyHdjXl2MiQ/GjHSw2ZRY+f0z0StkHWp6phA5jGNlqKdYb8QVUXEmO1lu6jatcwH752ywGsDFxwohT+FwEpZ077nOVjXtd8Ju16t5FwsJkp5sFG96inABubyS1bBSwuuBse5r0bO6gdunKzmYF7lMvHdSyYOXxI8BCz5EiPkY4fmHh0nElIkaytetDKVvsE/Soh1vkpvLzHOVpMoAmLUtqvZ3498c02O61O8D133qiJBU5DYtw0bCUygxKpesyK+Nqcljd+qcnbct+S/AWXRDDgW11rvbxuVDiIi6JLE7zNM9q4jqHM2a3rlAmfXBAI4PL1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe96qnYdAo7OiDGyMscuV+q9d3OmGU8/Hy3CPlO1rB0=;
 b=ewb/ftQ+hdfpuNOJb5w+iEAlSPwmtasR4TZK+bOV/+MD0goiYufQWhTA6EgFmg6pot868OWwNfiTiPvDymXJ5CYjoqFrsgU8YqUaMnDMeTfJBRerFYxQDGmorQz6R+kcV3lezScOuuNfczFYK08IunLJMx3tNKd5zueTTOulHrY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3963.namprd10.prod.outlook.com
 (2603:10b6:5:1f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 14:33:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 14:33:35 +0000
Date:   Wed, 6 Jul 2022 17:33:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSD: Convert the filecache to use rhashtable
Message-ID: <YsWdMVpiHhDjfEPg@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0168.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5337e7e8-5f0b-4af2-fb2a-08da5f5c823f
X-MS-TrafficTypeDiagnostic: DM6PR10MB3963:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Upb1JeMxjAB23UULf4gPtSSIbyxpYWBmMQJLSlnhRwSCBgTJ13EfNWB+GDNLefzU6hxIvYj0k/ja2IYSc1G4swC5nQeXWtAk08IizmnmpBNckNqJ0Xr8u7iTe6Poo98L1dtBJVl31SudmyIrQF6hrfQbfYOx7raP+MZKDa1SaiflZj4Y+MMWBF7KFAKcsLYE6vMquvB2WcKC7KPiPNiW50j40gNQFCVbLedR/K0Js4lRg1Dej2UNbFKYj/o2jtSwKTPq4fIUlIhU1eoebDU3DGfsqXuneAfvEhAYRsoe+74bz4QTO9YJG+TYNXPJ9d+f1vqKbPOHt3qfM+UNC3ycO2/e1rtVJGQlzeiq0p+GjEGr44lcl9GFtTlACEpafWfxiXAA+UUNx2druXFTlM8LOD6rOzpu2FpGcCjo3Zv8tj1WUk5pp+uqP53lJ1nRCLdCmk/gNwDaS5IecpDDx3eYsaYOLJiVNULWO3RJKcam8JXmDzE87XCyXFdy4AufDzKFiMo9ogbT7sGvMz9/wTEWR/BRbS1MJpDSr/ejha0pwm3Pb0rlG8VZfA83s2T70POPRhiA7S1U2igu+KQF0+gTLqEP3IgCnOgOcppKTly7ItkcLTiuB8NNE8RArW5Z5btjVFHE6c1vDnidL7O2ThqTZtp1uE3lBd7ix/yUIrRZN0oSahAg3fDQYlRO5wFSE3f+HwJMYfDTLrlNCIo209adLjwdMT6ap2Xhr2Y6gJ27hfzIoglnIuqYHePahkJ3s3cpJgpJUaSI9E84XSRFH4YPk8LS0+/+jpB0rEtu5+AVhKdqA9Y7EFIhmTBCroFGdcJy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(396003)(346002)(136003)(366004)(52116002)(6506007)(8936002)(478600001)(33716001)(5660300002)(38350700002)(2906002)(41300700001)(6666004)(8676002)(4326008)(66476007)(66556008)(38100700002)(44832011)(186003)(6486002)(6636002)(9686003)(6512007)(26005)(86362001)(83380400001)(316002)(66946007)(34206002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oyl4cEp8ntD/+jUwKL/CcgNS6KXbhGUKixbFCnPz7RPWekR30FOEbj0ZGuKY?=
 =?us-ascii?Q?iSRZbHCdNcih7Jvd0YuqY8V/AQ5af8dlYreGF9e4mYkbV4bdvpovd56y1EPA?=
 =?us-ascii?Q?4oki077OteWxFwozw6WAloUdJm2q/soNo3jJk8QZzutZ2Q42QbVn5YnTMz8L?=
 =?us-ascii?Q?HwYJ1IkiMz+FkKrHtLdQ6qOjjOh1DveDErWdlk104EK/XXvvt+4JVWFkZdJM?=
 =?us-ascii?Q?NBUrSi1zKUNB542QRM0sO5i8hnN+T4AhBby9Dk/Av/eR4IQ64pxMXdcOBg5x?=
 =?us-ascii?Q?HESYpZosnaxMNg0doeDlWMyXKAYKGyFgTeDajUDHLBtQfWXdoLBsOFmeXYoQ?=
 =?us-ascii?Q?kEDVaQ+kTRBp8i3oVB1bMtyxTeJ9cQl+THXO4JT1P3MxqCRrUEnvroZ9tLLk?=
 =?us-ascii?Q?8MwAQwbqkEu6ubVeZDSjXajF1qg1SGwamgH64lME4BlPpxIPLD+mu2aPMVMf?=
 =?us-ascii?Q?e4doW2y4VU0fwtwRFgkCiEkxHfaekTSp8AKkfFn/fYUO1aAyd6AUh8HZI3jU?=
 =?us-ascii?Q?aHZldxehyyt8M8pC/pI9/+N9EzLHyqUfj3JmK0k/2pyQceNnaxXVqfnH8hh0?=
 =?us-ascii?Q?vwOCLLi696LHav+xE1fa1bqQGxVToU7SOsZF1L6Ax5RxCn26Qr14nYU5lfQu?=
 =?us-ascii?Q?RnlvUePQgF3iD52acXIMhw2d+LfiYCT16aLW7EuRfx7vmyTKxhTh/TTrAarm?=
 =?us-ascii?Q?mFTCDXXU0x0IHAE/XF7SS3TivpWRIO9eu0pZdZmYYsK2GIKImYZ92SwEC/XF?=
 =?us-ascii?Q?Gd/daGO6chYow27fYwIjNc6x2aL4lP8Zpz3xfQfWLgKltWxgGIepQbBH9G8H?=
 =?us-ascii?Q?srZEkdAWi28zFx82KeDj3iKKONSp2eVz5W5qHsGjVE2752gyuK05YaH3Q+Ci?=
 =?us-ascii?Q?4fCr2wqSzeATggWbSVoREmkx8u7kjfJDeu78AvqvyglAw+5Q9goIwGjSA93+?=
 =?us-ascii?Q?P5OKlrD5/qLkYk4o86s3Z/tlfeF2Ey+CPVo/k2KkDGjrZ8GcrGwDIVkG6Bj5?=
 =?us-ascii?Q?R1G36ttiZDmSBjkPcRiblzzLNf8UztZK9EI0mQfH0ZTwH9vRQ4qJzZSat2+7?=
 =?us-ascii?Q?1YdVVseatfE4XjsdR4KEZ2Os9TwPqHbAyoZcIUxKJaxwgywfzD53bl+HNuKC?=
 =?us-ascii?Q?o29HtBvyL/CRN28VID+KXRufUYC17jcAq7KUvhx8u5XtIye+sTwIBzqAFJeS?=
 =?us-ascii?Q?+TMhV3Wtqr9kss0oQlmEWHjFtmzultBUQw/2T12ercArREgkmT/3RlYAdw1S?=
 =?us-ascii?Q?JP/3FcM193q/Qrt3tUMCcjF71ycPamsnICGnLsUWF+iCUPrgXHLsGfoSZtiK?=
 =?us-ascii?Q?pMMc4Wl4STT2ZpKPHF6czLx8R2VijhSh9xK3DoA3g6xD9jKd8U4FjQCP1rcy?=
 =?us-ascii?Q?NJYwa0zxQv94U+URebTW5iPXAxIGhrqPPU2p+vwbkwp8tS523LkYggfcgEFV?=
 =?us-ascii?Q?JgF50Lz7U+ti/upyglUj3D+7MSnohFsSPrgX+1kMOdW2+hwV7pecJe104C47?=
 =?us-ascii?Q?1t34q+bcHrCoGj+o9bthroYpcvSwgcm8lvY87b4qdym5Q8AXSkDlR/o3I7Bx?=
 =?us-ascii?Q?rv52FzX6m4Dd0l1ufYLTcvV6VpEGwy5ql4nmeSjgZo4UfN4sWdJh/CYxT+0E?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5337e7e8-5f0b-4af2-fb2a-08da5f5c823f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:33:35.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F3Oqo+Fdb4inGhTrpNcWXH+Viq2vf0T35V0lgwDmzbh13XcExAEPw2oOQ6C7tCucayksMtjjm6TW8BUrAi1UhEwyL/Fu0UnXLs4hoQ8SkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3963
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=522
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060057
X-Proofpoint-ORIG-GUID: iwYKzQPRbb6zGGog8IU0EWQtGiTlPRb9
X-Proofpoint-GUID: iwYKzQPRbb6zGGog8IU0EWQtGiTlPRb9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Chuck Lever,

The patch 125b58c13f71: "NFSD: Convert the filecache to use
rhashtable" from Jun 28, 2022, leads to the following Smatch static
checker warning:

	fs/nfsd/filecache.c:1117 nfsd_file_do_acquire()
	warn: 'new' was already freed.

fs/nfsd/filecache.c
    1066 static __be32
    1067 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
    1068                      unsigned int may_flags, struct nfsd_file **pnf, bool open)
    1069 {
    1070         struct nfsd_file_lookup_key key = {
    1071                 .type        = NFSD_FILE_KEY_FULL,
    1072                 .need        = may_flags & NFSD_FILE_MAY_MASK,
    1073                 .net        = SVC_NET(rqstp),
    1074                 .cred        = current_cred(),
    1075         };
    1076         struct nfsd_file *nf, *new;
    1077         bool retry = true;
    1078         __be32 status;
    1079 
    1080         status = fh_verify(rqstp, fhp, S_IFREG,
    1081                                 may_flags|NFSD_MAY_OWNER_OVERRIDE);
    1082         if (status != nfs_ok)
    1083                 return status;
    1084         key.inode = d_inode(fhp->fh_dentry);
    1085 
    1086 retry:
    1087         /* Avoid allocation if the item is already in cache */
    1088         nf = rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
    1089                                     nfsd_file_rhash_params);
    1090         if (nf)
    1091                 nf = nfsd_file_get(nf);
    1092         if (nf)
    1093                 goto wait_for_construction;
    1094 
    1095         new = nfsd_file_alloc(&key, may_flags);
    1096         if (!new) {
    1097                 status = nfserr_jukebox;
    1098                 goto out_status;
    1099         }
    1100 
    1101         nf = rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
    1102                                               &key, &new->nf_rhash,
    1103                                               nfsd_file_rhash_params);
    1104         if (!nf) {
    1105                 nf = new;
    1106                 goto open_file;
    1107         }
    1108         nfsd_file_slab_free(&new->nf_rcu);
                                      ^^^^^^^^^^^
This frees "new".

    1109         if (IS_ERR(nf)) {
    1110                 trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
    1111                 nf = NULL;
    1112                 status = nfserr_jukebox;
    1113                 goto out_status;
    1114         }
    1115         nf = nfsd_file_get(nf);
    1116         if (nf == NULL) {
--> 1117                 nf = new;
                              ^^^
Use after free

    1118                 goto open_file;
    1119         }
    1120 
    1121 wait_for_construction:
    1122         wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
    1123 
    1124         /* Did construction of this file fail? */
    1125         if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
    1126                 trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
    1127                 if (!retry) {
    1128                         status = nfserr_jukebox;
    1129                         goto out;
    1130                 }
    1131                 retry = false;
    1132                 nfsd_file_put_noref(nf);
    1133                 goto retry;
    1134         }
    1135 
    1136         nfsd_file_lru_remove(nf);
    1137         this_cpu_inc(nfsd_file_cache_hits);
    1138 
    1139         if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
    1140                 bool write = (may_flags & NFSD_MAY_WRITE);
    1141 
    1142                 if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags) ||
    1143                     (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flags) && write)) {
    1144                         status = nfserrno(nfsd_open_break_lease(
    1145                                         file_inode(nf->nf_file), may_flags));
    1146                         if (status == nfs_ok) {
    1147                                 clear_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
    1148                                 if (write)
    1149                                         clear_bit(NFSD_FILE_BREAK_WRITE,
    1150                                                   &nf->nf_flags);
    1151                         }
    1152                 }
    1153         }
    1154 out:
    1155         if (status == nfs_ok) {
    1156                 if (open)
    1157                         this_cpu_inc(nfsd_file_acquisitions);
    1158                 *pnf = nf;
    1159         } else {
    1160                 nfsd_file_put(nf);
    1161                 nf = NULL;
    1162         }
    1163 
    1164 out_status:
    1165         if (open)
    1166                 trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
    1167         return status;
    1168 
    1169 open_file:
    1170         trace_nfsd_file_alloc(nf);
    1171         nf->nf_mark = nfsd_file_mark_find_or_create(nf);
    1172         if (nf->nf_mark) {
    1173                 if (open) {
    1174                         status = nfsd_open_verified(rqstp, fhp, may_flags,
    1175                                                     &nf->nf_file);
    1176                         trace_nfsd_file_open(nf, status);
    1177                 } else
    1178                         status = nfs_ok;
    1179         } else
    1180                 status = nfserr_jukebox;
    1181         /*
    1182          * If construction failed, or we raced with a call to unlink()
    1183          * then unhash.
    1184          */
    1185         if (status != nfs_ok || key.inode->i_nlink == 0)
    1186                 if (nfsd_file_unhash(nf))
    1187                         nfsd_file_put_noref(nf);
    1188         clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
    1189         smp_mb__after_atomic();
    1190         wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
    1191         goto out;
    1192 }

regards,
dan carpenter
